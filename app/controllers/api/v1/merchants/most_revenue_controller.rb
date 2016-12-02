class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: Merchant.top_revenue(params[:quantity])
  end

end
