class CreateAggregatedMarketPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :aggregated_market_prices do |t|
      t.decimal :open
      t.decimal :close
      t.decimal :high
      t.decimal :volume
      t.datetime :price_date
      t.references :market
      t.integer :interval_type
      t.timestamps
    end
  end
end
