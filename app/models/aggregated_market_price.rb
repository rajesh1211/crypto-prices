class AggregatedMarketPrice < ApplicationRecord
  belongs_to :market
  enum interval_types: {five_minutes: 5, fifteen_minutes: 15, thirty_minutes: 30, sixty_minutes: 60}
end
