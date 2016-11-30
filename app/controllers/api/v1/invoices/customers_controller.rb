class Api::V1::Invoices::CustomersController < ApplicationController

    def index
      byebug
      render json: InvoiceItem.where("invoice_id" => params[:id])
    end

    private

    def item_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
