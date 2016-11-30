require 'rails_helper'

describe 'invoice_items endpoint' do
  before(:each) do
    create(:merchant)
    create(:customer)
    create(:item, merchant_id: Merchant.first.id)
    create(:invoice, merchant_id: Merchant.first.id, customer_id: Customer.first.id)
  end
  context 'GET invoice_items' do
    it 'returns a list of all invoice_items' do
      create_list(:invoice_item, 3, item_id: Item.first.id ,invoice_id: Invoice.first.id)
      get '/api/v1/invoice_items'

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end

  context 'GET an invoice_item' do
    it 'returns an invoice_item' do
      create_list(:invoice_item, 3, item_id: Item.first.id, invoice_id: Invoice.first.id)
      get "/api/v1/invoice_items/#{InvoiceItem.first.id}"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.first[1]).to eq(InvoiceItem.first.id)
    end
  end

  context 'GET a invoice_item by attribute' do
    it 'returns an invoice_item' do
      create_list(:invoice_item, 3, item_id: Item.first.id, invoice_id: Invoice.first.id)

      get "/api/v1/invoice_items/find?quantity=#{InvoiceItem.first.quantity}"

      invoice_items = JSON.parse(response.body)
      expect(response).to be_success
      expect(invoice_items["quantity"]).to eq(InvoiceItem.first.quantity)
    end
  end

  context 'GET invoice_items by attribute' do
    it 'returns invoice_items' do
      create_list(:invoice_item, 3, item_id: Item.first.id, invoice_id: Invoice.first.id, unit_price: 12345)
      create(:invoice_item, item_id: Item.first.id, invoice_id: Invoice.first.id, unit_price: 9876)

      get "/api/v1/invoice_items/find_all?unit_price=#{InvoiceItem.first.unit_price}"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end
end
