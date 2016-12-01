class Api::V1::InvoiceItems::SearchController < ApplicationController
  before_action :format_unit_price

  def show
    render json: InvoiceItem.find_by(invoice_items_params)
  end

  def index
    render json: InvoiceItem.where(invoice_items_params)
  end

  private

  def format_unit_price
    if params[:unit_price]
      params[:unit_price] = ((params["unit_price"].to_f) * 100.00).to_i
      invoice_items_params
    else
      invoice_items_params
    end
  end

  def invoice_items_params
      params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

end
