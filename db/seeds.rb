# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BittrexService.fetch_markets!["result"].each do |market|
  unless Market.exists?(name: market["MarketName"])
    Market.create!(name: market["MarketName"])
    puts "#{market["MarketName"]} has been seeded"
  end
end
