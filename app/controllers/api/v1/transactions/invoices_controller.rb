class Api::V1::Transactions::InvoicesController < ApplicationController

  def index
    render json: Transaction.find(transaction_params[:id]).invoice
  end

  private

  def transaction_params
    params.permit(:id, :invoice_id, :credit_card_number, :credit_card_expiration_date)
  end
end
