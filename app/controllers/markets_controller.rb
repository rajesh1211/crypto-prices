class MarketsController < ApplicationController

  # /api/v1/markets
  def index
    render json: Market.all.as_json(only: [:id, :name]), status: :ok
  end

  # /api/v1/markets/prices/BTC-LTC
  def prices
    if params[:market_name].present?
      if Market.exists?(name: params[:market_name])
        @market = Market.find_by_name(params[:market_name])
        render json: @market.market_prices.last, status: :ok
      else
        render json: {message: "Market not found"}, status: 404
      end
    else
      render json: {message: "Please provide market name"}, status: 422
    end
  end

  # /api/v1/trigger_sanity_check
  def trigger_sanity_check
    DataQualityJob.new.perform
    render json: {message: "Report has benn mailed to concerned person"}, status: :ok
  end
end
