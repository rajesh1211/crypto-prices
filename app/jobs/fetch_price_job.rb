class FetchPriceJob
  DEFAULT_TICK_INTERVAL = :oneMin
  AGGRGATED_TIME_INTERVALS = [5, 15, 30, 60]
  RESPONSE_KEYS = {
    open: "O",
    high: "H",
    close: "C",
    volume: "V",
    timestamp: "T"
  }

  def perform
    begin
      # Get supported coins
      markets = Market.where(name: ENV["SUPPORTED_COINS"].split)
      markets.each do |market|
        response = BittrexService.fetch_market_prices!(
          marketName: market.name, tickInterval: DEFAULT_TICK_INTERVAL
        )
        # Guard condition if no data is available
        next if response["result"].nil? || response["result"].empty?
        latest_date = Date.parse(response["result"].last["T"])
        latest_records = response["result"].select{|item| Date.parse(item["T"]) >= latest_date}

        latest_records.each do |res|
          unless market.market_prices.exists?(price_date: res["T"])
            market.market_prices <<
              MarketPrice.new(
                open: res[RESPONSE_KEYS[:open]],
                high: res[RESPONSE_KEYS[:high]],
                close: res[RESPONSE_KEYS[:open]],
                volume: res[RESPONSE_KEYS[:volume]],
                price_date: res[RESPONSE_KEYS[:timestamp]]
              )
          end
        end
        market.save!
        save_aggregated_data(market)
        puts "Prices saved for #{market.name}"
      end

    rescue => e
      # This might raise alert to something like Raygun
      Rails.logger.error("Price fetch failed")
    end
  end

  private
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
