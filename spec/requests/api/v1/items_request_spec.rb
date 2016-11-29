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

  context 'GET a item by attribute' do
    it 'returns an item' do
      create_list(:item, 3, merchant_id: Merchant.first.id)

      get "/api/v1/items/find?name=#{Item.first.created_at}"
      get "/api/v1/items/find?name=#{Item.first.name}"

      item = JSON.parse(response.body)
      expect(response).to be_success
      expect(item["name"]).to eq(Item.first.name)


      get "/api/v1/items/find?id=#{Item.first.id}"
      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.first[1]).to eq(Item.first.id)
    end
  end

  context 'GET items by attribute' do
    it 'returns items' do
      create_list(:item, 3, merchant_id: Merchant.first.id)

      get '/api/v1/items/find_all?name=Frank'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
end
