class Api::V1::Invoices::ItemsController < ApplicationController

    def index
      render json: Invoice.find(params[:id]).items
    end

    private

    def item_params
      params.permit(:id, :status, :customer_id, :merchant_id, :created_at, :updated_at)
    end
end
