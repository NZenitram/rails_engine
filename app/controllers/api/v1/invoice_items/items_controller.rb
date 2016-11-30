class Api::V1::InvoiceItems::ItemsController < ApplicationController

  def show
    render json: InvoiceItem.find(params[:id].to_i).item
  end
end
