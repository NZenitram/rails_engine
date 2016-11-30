class Api::V1::Invoices::MerchantsController < ApplicationController

    def index
      render json: Invoice.find(params[:id].to_i).merchant
    end
end
