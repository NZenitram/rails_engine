class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: Item.where(merchant_id: merchant_params[:id].to_i)
  end

  def merchant_params
    params.permit(:id, :name)
  end
end
