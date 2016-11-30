class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def show
    render json: InvoiceItem.find(params[:id].to_i).invoice
  end
end
