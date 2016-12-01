class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.find(params[:id]).total_revenue(params[:date]), serializer: MerchantrevenueSerializer
  end

end
