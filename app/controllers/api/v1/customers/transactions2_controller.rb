class Api::V1::Customers::Transactions2Controller < ApplicationController

  def index
    render json: Customer.find(params[:id]).transactions
  end

  private

  def customer_params
    params.permit(:id, :customer_id, :first_name, :last_name, :created_at, :updated_at)
  end
end
