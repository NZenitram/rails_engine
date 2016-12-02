class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.find(params[:id]).total_revenue(params[:date]), serializer: MerchantrevenueSerializer
  end

  def show
    render json: Merchant.revenue_by_date(params[:date]), serializer: RevenueByDateSerializer
  end

end
