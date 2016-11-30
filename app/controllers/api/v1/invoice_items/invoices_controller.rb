class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def show
    byebug
    render json: InvoiceItem.find_by(invoice_items_params)
  end
end
