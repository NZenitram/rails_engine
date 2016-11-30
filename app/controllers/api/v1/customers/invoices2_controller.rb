class Api::V1::Customers::Invoices2Controller < ApplicationController

  def index
      render json: Invoice.where(customer_id: customer_params[:id])
  end

  private

  def customer_params
    params.permit(:id, :customer_id, :first_name, :last_name, :created_at, :updated_at)
  end
end
