class Api::V1::Invoices::CustomersController < ApplicationController

    def index
      render json: Invoice.find(params[:id].to_i).customer
    end

    private

    def item_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
