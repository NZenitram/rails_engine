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
      expect(customer["first_name"]).to eq(Customer.first.first_name)
    end
  end

  context "GET a customer by ID" do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/find?id=#{Customer.first.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq(Customer.first.first_name)
    end
  end
  context "GET a customer by first_name" do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/find?first_name=#{Customer.first.first_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq(Customer.first.first_name)
    end
  end
  context "GET a customer by last_name" do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/find?last_name=#{Customer.first.last_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.first[1]).to eq(Customer.first.id)
    end
  end

  context "GET all customers by first_name" do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/find_all?id=#{Customer.first.id}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.first["first_name"]).to eq(Customer.first.first_name)
    end
  end

  context "GET all customers by first_name" do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/find_all?first_name=#{Customer.first.first_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.first["first_name"]).to eq(Customer.first.first_name)
    end
  end

  context "GET all customers by last_name" do
    it 'returns a customer' do
      create_list(:customer, 3)
      get "/api/v1/customers/find_all?last_name=#{Customer.first.last_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.first["first_name"]).to eq(Customer.first.first_name)
    end
  end

  # context "GET all customers by created_at" do
  #   it 'returns a customer' do
  #     create_list(:customer, 3)
  #     get "/api/v1/customers/find_all?created_at=#{Customer.first.created_at}"
  #
  #     customer = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(customer["first_name"]).to eq(Customer.first.first_name)
  #   end
  # end
  #
  # context "GET all customers by updated_at" do
  #   it 'returns a customer' do
  #     create_list(:customer, 3)
  #     get "/api/v1/customers/find_all?updated_at=#{Customer.first.updated_at}"
  #
  #     customer = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(customer["first_name"]).to eq(Customer.first.first_name)
  #   end
  # end
end
