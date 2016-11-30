class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    render json: InvoiceItem.find_by(merchant_params)
  end

  def index
    render json: InvoiceItem.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end
end
