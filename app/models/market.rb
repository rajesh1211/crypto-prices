class Market < ApplicationRecord
  has_many :market_prices, autosave: true
  has_many :aggregated_market_prices, autosave: true
end
