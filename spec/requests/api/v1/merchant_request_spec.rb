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
  #     get "/api/v1/merchants/find?created_at=#{Merchant.first.updated_at}"
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

  context "GET all merchants by params" do
    it "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{Merchant.first.name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end

  context "GET all merchants by params" do
    it "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{Merchant.first.created_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end

  context "GET all merchants by params" do
    it "returns the merchants" do
      create_list(:merchant, 3)

      get "/api/v1/merchants/find_all?id=#{Merchant.first.updated_at}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.count).to eq(3)
    end
  end
end
