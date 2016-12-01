class Api::V1::Items::SearchController < ApplicationController
  before_action :format_unit_price

  def show
    render json: Item.find_by(merchant_params)
  end

  def index
    render json: Item.where(merchant_params)
  end

  private

  def format_unit_price
    if params[:unit_price]
      params[:unit_price] = ((params["unit_price"].to_f) * 100.00).ceil
      merchant_params
    else
      merchant_params
    end
  end

  def merchant_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
