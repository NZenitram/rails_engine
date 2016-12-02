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

  context "Find a merchant by ID" do
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

  context "GET total revenue for a merchant" do
    it "returns total_revenue" do
      create(:merchant)
      create(:invoice, merchant_id: Merchant.first.id)
      create_list(:invoice_item, 2, invoice_id: Invoice.first.id)
      create(:invoice_item)
      create_list(:transaction, 2, invoice_id: Invoice.first.id )

      get "/api/v1/merchants/#{Merchant.first.id}/revenue"

      expect(response).to be_success
      expect(Merchant.first.total_revenue).to eq(24680)

    end
  end

  context "GET total revenue for a merchant" do
    it "returns revenue for a specific date" do
      date = Time.now.utc
      create(:merchant)
      create(:invoice, merchant_id: Merchant.first.id)
      create_list(:invoice_item, 2, invoice_id: Invoice.first.id)
      create(:invoice_item)
      create_list(:transaction, 2, invoice_id: Invoice.first.id )

      get "/api/v1/merchants/#{Merchant.first.id}/revenue?date=#{date}"

      expect(response).to be_success
    end
  end

  context "GET favorite_customer for a merchant" do
    it "returns favorite_customer for a merchant" do
      create_list(:customer, 2)
      create(:merchant)
      create_list(:invoice, 2, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
      create(:invoice, customer_id: Customer.last.id, merchant_id: Merchant.first.id)
      create_list(:transaction, 2, invoice_id: Invoice.first.id )

      get "/api/v1/merchants/#{Merchant.first.id}/favorite_customer"

      customer = JSON.parse(response.body)

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
      expect(fav_customer["id"]).to eq(Customer.first.id)
    end
  end

  context 'GET top merchants' do
    it 'returns top merchant by number of items sold' do
      create_list(:merchant, 4)
      create_list(:customer, 2)
      create_list(:item, 2)
      create(:invoice, merchant_id: Merchant.first.id, customer_id: Customer.first.id)
      create(:invoice, merchant_id: Merchant.first.id, customer_id: Customer.last.id)
      create(:transaction, invoice_id: Invoice.first.id)
      create(:invoice_item, item_id: Item.first.id, quantity: 16)
      create(:invoice_item, item_id: Item.second.id, quantity:4)
      create(:transaction, invoice_id: Invoice.second.id)

      get '/api/v1/merchants/most_items?quantity=2'

      top_merchants = JSON.parse(response.body)

      expect(response).to be_success
    end
  end
end
