require 'rails_helper'

describe 'merchant endpoint' do
  context 'GET merchants' do
    it 'returns a list of all merchants' do
      create_list(:merchant, 3)
      get '/api/v1/merchants'

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(3)
    end
  end

  context 'GET a merchant' do
    it 'returns a merchant' do
      create_list(:merchant, 3)
      get "/api/v1/merchants/#{Merchant.first.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first[1]).to eq(Merchant.first.id)
    end
  end
  context "GET a merchant by ID" do
    it "returns the merchant" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find?id=#{Merchant.first.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first[1]).to eq(Merchant.first.id)
    end
  end

  context "GET a merchant by name" do
    it "returns the merchant" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find?name=#{Merchant.first.name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first[1]).to eq(Merchant.first.id)
    end
  end
  #
  # context "GET a merchant by created_at" do
  #   it "returns the merchant" do
  #     create_list(:merchant, 3)
  #
  #     get "/api/v1/merchants/find?created_at=#{Merchant.first.created_at}"
  #
  #     merchant = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(merchant.first[1]).to eq(Merchant.first.id)
  #   end
  # end
  #
  # context "GET a merchant by created_at" do
  #   it "returns the merchant" do
  #     create_list(:merchant, 3)
  #
  #     get "/api/v1/merchants/find?updated_at=#{Merchant.first.updated_at}"
  #
  #     merchant = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(merchant.first[1]).to eq(Merchant.first.id)
  #   end
  # end

  context "GET all merchants by params" do
    it "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{Merchant.first.id}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant[0]["id"]).to eq(Merchant.first.id)
    end
  end

  context "GET all merchants by name" do
    it "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?name=#{Merchant.first.name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end

  context "GET all merchants by created_at" do
    xit "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?created_at=#{Merchant.first.created_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end

  context "GET all merchants by updated_at" do
    xit "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?updated_at=#{Merchant.first.updated_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end

  context "GET total revenue for a merchant" do
    it "returns total_revenue" do
      create(:merchant)
      create_list(:invoice, 3, merchant_id: Merchant.first.id)
      create(:transaction, invoice_id: Invoice.first.id, result: "success")
      create(:transaction, invoice_id: Invoice.second.id, result: "success")
      create(:transaction, invoice_id: Invoice.last.id, result: "failed")
      create_list(:invoice_item, 3, unit_price: 5, quantity: 1 )

      get "/api/v1/merchants/#{Merchant.first.id}/revenue"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
    end
  end

  context 'GET favorite customer for a merchant' do
    it 'returns customer with the most successful transactions' do
      create_list(:customer, 2)
      create(:merchant)
      create_list(:invoice, 3, merchant_id: Merchant.first.id, customer_id: Customer.first.id)
      create_list(:invoice, 2, merchant_id: Merchant.first.id, customer_id: Customer.last.id)
      create_list(:transaction, 3, invoice_id: Invoice.first.id, result: "success")
      create_list(:transaction, 4, invoice_id: Invoice.first.id, result: "failure")
      create_list(:transaction, 2, invoice_id: Invoice.last.id, result: "success")

      get "/api/v1/merchants/#{Merchant.first.id}/favorite_customer"

      fav_customer = JSON.parse(response.body)

      expect(response).to be_success
      # expect(fav_customer).to eq(Customer.first)
    end
  end
end
