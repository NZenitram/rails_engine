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

  context 'GET items by revenue' do
    it 'returns items by revenue' do
      create_list(:item, 3)
      create_list(:invoice, 3)
      create(:transaction, result: 'success', invoice_id: Invoice.first.id)
      create(:transaction, result: 'success', invoice_id: Invoice.last.id)
      create(:invoice_item, invoice_id: Invoice.first.id, item_id: Item.first.id, quantity: 15, unit_price: 5)
      create(:invoice_item, invoice_id: Invoice.second.id, item_id: Item.first.id, quantity: 15, unit_price: 5)
      create(:invoice_item, invoice_id: Invoice.last.id, item_id: Item.last.id, quantity: 12, unit_price: 2)

      get '/api/v1/items/most_revenue?quantity=2'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
    end
  end

  context 'GET items by quantity sold' do
    it 'returns items by revenue' do
      create_list(:item, 3)
      create_list(:invoice, 3)
      create(:transaction, result: 'success', invoice_id: Invoice.first.id)
      create(:transaction, result: 'success', invoice_id: Invoice.last.id)
      create(:invoice_item, invoice_id: Invoice.first.id, item_id: Item.first.id, quantity: 15, unit_price: 5)
      create(:invoice_item, invoice_id: Invoice.last.id, item_id: Item.last.id, quantity: 12, unit_price: 2)
      create(:invoice_item, invoice_id: Invoice.last.id, item_id: Item.second.id, quantity: 1, unit_price: 2)

      get '/api/v1/items/most_items?quantity=2'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)
      expect(items.first["id"]).to eq(Item.first.id)
    end
  end
end
