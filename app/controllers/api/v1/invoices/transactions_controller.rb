class Api::V1::Invoices::TransactionsController < ApplicationController

    def index
      render json: Invoice.find(params[:id]).transactions
    end

    private

    def invoice_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
