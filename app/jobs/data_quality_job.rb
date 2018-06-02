class DataQualityJob
  EXPECTED_DATA_COUNT = 1440
  def initialize(date: Date.current)
    @date = date
  end

  def perform
    markets = Market.where(name: ENV["SUPPORTED_COINS"].split)
    total_markets = markets.count
    stats = {
      total_markets: total_markets,
      total_expected_data_points: total_markets * EXPECTED_DATA_COUNT
    }

    market_data_points = {}
    total_data_points = 0
    markets.each do |market|
      available_data_count = market.market_prices.where("date(price_date) = ?", @date).count
      market_data_points[market.name] = (available_data_count.to_d / EXPECTED_DATA_COUNT) * 100
      total_data_points = total_data_points + available_data_count
    end
    total_percentage_of_data_points = (total_data_points.to_d / (total_markets * EXPECTED_DATA_COUNT)) * 100
    stats[:total_percentage_of_data_points] = total_percentage_of_data_points
    stats[:market_data_points] = market_data_points

    NotificationMailer.sanity_check_email(stats).deliver_now
  end
end
