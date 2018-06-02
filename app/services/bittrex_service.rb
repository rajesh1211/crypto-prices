class BittrexService

  FETCH_MARKET_URL =  "#{ENV['BITTREX_HOST']}/public/getmarkets"
  FETCH_MARKET_PRICE_URL =  "#{ENV['BITTREX_PRICE_HOST']}/pub/market/GetTicks?marketName=%{marketName}&tickInterval=%{tickInterval}"

  def self.fetch_markets!
    Request.new(FETCH_MARKET_URL, nil).get!
  end

  def self.fetch_market_prices!(params)
    Request.new(FETCH_MARKET_PRICE_URL, params).get!
  end
end
