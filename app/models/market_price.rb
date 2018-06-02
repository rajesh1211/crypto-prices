class MarketPrice < ApplicationRecord
  belongs_to :market
  validates :open, :close, :high, :volume, :price_date , presence: true
end
