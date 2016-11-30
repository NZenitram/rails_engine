class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    render json: Invoice.where(merchant_id: merchant_params[:id].to_i)
  end

  def merchant_params
    params.permit(:id, :name)
  end
end
