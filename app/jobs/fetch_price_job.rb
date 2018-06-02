class FetchPriceJob
  DEFAULT_TICK_INTERVAL = :oneMin
  AGGRGATED_TIME_INTERVALS = [5, 15, 30, 60]
  def perform
    begin
      markets = Market.where(name: ENV["SUPPORTED_COINS"].split)
      markets.each do |market|
        response = BittrexService.fetch_market_prices!(marketName: market.name, tickInterval: DEFAULT_TICK_INTERVAL)
        next if response["result"].nil? || response["result"].empty?
        latest_date = Date.parse(response["result"].last["T"])
        latest_records = response["result"].select{|item| Date.parse(item["T"]) >= latest_date}

        latest_records.each do |res|
          puts res["T"]
          unless market.market_prices.exists?(price_date: res["T"])
            market.market_prices <<
              MarketPrice.new(
                market: market,
                open: res["O"],
                high: res["H"],
                close: res["C"],
                volume: res["V"],
                price_date: res["T"]
              )
          end
        end
        market.save!

        save_aggregated_data(market)
      end

    rescue => e
      # This might raise alert to something like Raygun
      Rails.logger.error("Daily price fetch failed")
    end
  end

  def save_aggregated_data(market)
    market_prices = market.market_prices
    last_record_available = market_prices.last.price_date

    AGGRGATED_TIME_INTERVALS.each do |interval|
      last_time = last_record_available - interval.minutes
      time_bucket = {}
      while last_time.to_date > (last_record_available.to_date - 1) do
        time_bucket[last_time] = market_prices.select{|price| price.price_date >= last_time}
        last_time = last_time - interval.minutes
      end


      time_bucket.each do | time, prices|
        unless market.aggregated_market_prices.exists?(interval_type: interval, price_date: time)
          market.aggregated_market_prices << AggregatedMarketPrice.new(
            market: market,
            open: prices.first.open,
            high: prices.max_by(&:high),
            close: prices.first.close,
            volume: prices.sum(&:volume),
            price_date: time,
            interval_type: interval
          )
        end
      end
      market.save!
    end
  end
end
