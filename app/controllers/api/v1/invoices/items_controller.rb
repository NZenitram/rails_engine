class Api::V1::Invoices::ItemsController < ApplicationController

    def index
      render json: InvoiceItem.where("invoice_id" => params[:id])
    end

    private

    def item_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
