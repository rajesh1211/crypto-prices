BittrexService.fetch_markets!["result"].each do |market|
  unless Market.exists?(name: market["MarketName"])
    Market.create!(name: market["MarketName"])
    puts "#{market["MarketName"]} has been seeded"
  end
end

FetchPriceJob.new.perform
