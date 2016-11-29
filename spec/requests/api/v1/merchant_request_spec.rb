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
  # context "GET a merchant's revenue" do
  #   it "returns the revenue for a merchant" do
  #     create_list(:merchant, 3)
  #
  #     get "/api/v1/merchants/#{Merchant.first.id}/revenue"
  #
  #     expect(response).to be_success
  #   end
  # end
end
