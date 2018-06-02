class AggregatedMarketPrice < ApplicationRecord
  belongs_to :market
  enum interval_types: {five_minutes: 5, fifteen_minutes: 15, thirty_minutes: 30, sixty_minutes: 60}
  validates :open, :close, :high, :volume, :price_date , presence: true
end
