require 'rails_helper'

describe AggregatedMarketPrice do
  it { should validate_presence_of(:open) }
  it { should validate_presence_of(:close) }
  it { should validate_presence_of(:high) }
  it { should validate_presence_of(:volume) }
  it { should validate_presence_of(:price_date) }
end
