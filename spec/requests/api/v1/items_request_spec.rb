require 'rails_helper'

describe 'items endpoint' do
  before(:each) do
    create(:merchant)
  end

  context 'GET items' do
    it 'returns a list of all items' do
      create_list(:item, 3, merchant_id: Merchant.first.id)
      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end

  context 'GET a item' do
    it 'returns an item' do
      create_list(:item, 3, merchant_id: Merchant.first.id)
      get "/api/v1/items/#{Item.first.id}"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.first[1]).to eq(Item.first.id)

    end
  end
  end
end
