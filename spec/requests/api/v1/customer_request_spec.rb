require 'rails_helper'

describe 'customer endpoint' do
  before(:each) do
    create_list(:customer, 1)
    create_list(:merchant, 1)
    FactoryGirl.create(:invoice, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
  end
  context 'GET customers' do
    it 'returns a list of all customers' do
      create_list(:customer, 3)
      get '/api/v1/customers'

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(4)
    end
  end
  #
  context 'GET a customer' do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/#{Customer.first.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.first[1]).to eq(Customer.first.id)
    end
  end
end
