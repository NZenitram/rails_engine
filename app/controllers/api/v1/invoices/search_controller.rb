class Api::V1::Invoices::SearchController < ApplicationController

  def show
    render json: Invoice.find_by(merchant_params)
  end

  def index
    render json: Invoice.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
  end
end
