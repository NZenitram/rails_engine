class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    byebug
    render json: Merchant.find(params[:id]).total_revenue
  end



end
