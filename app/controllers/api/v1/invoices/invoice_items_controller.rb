class Api::V1::Invoices::InvoiceItemsController < ApplicationController

    def index
      render json: InvoiceItem.where("invoice_id" => params[:id])
    end

    private

    def invoice_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
