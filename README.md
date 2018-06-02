# Crypto Price Tracker

Crypto tracker allow you to maintain the price data of of different specified crypto markets, Following are the features:
  - Supported exchange: currently only bittrex is supported
  - APIs to fetch crypto prices
  - Maintians 1 min , 5 min, 15 min, 30 min, 60 min tick data

### Tech
  - /api/v1/markets
  - /api/v1/markets/prices/BTC-XPR
  - /api/v1/markets/trigger_sanity_check

### Installation

clone the project and run, add required environment variables into .env file

```sh
$ bundle install
$ rake db:create db:migrate db:seed
$ rails s
```
