require 'rails_helper'


describe 'invoice_items relation endpoint' do
  before(:each) do
    create(:merchant)
    create(:customer)
    create(:item, merchant_id: Merchant.first.id)
    create(:invoice, merchant_id: Merchant.first.id, customer_id: Customer.first.id)
  end
  context 'GET invoice through invoice_items' do
    it 'returns an invoice' do
      create_list(:invoice_item, 3, item_id: Item.first.id ,invoice_id: Invoice.first.id)

      get "/api/v1/invoice_items/#{InvoiceItem.first.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["id"]).to eq(Invoice.first.id)
    end
  end
  context "GET item through invoice_items" do
    it 'returns an item' do
      create_list(:invoice_item, 3, item_id: Item.first.id ,invoice_id: Invoice.first.id)

      get "/api/v1/invoice_items/#{InvoiceItem.first.id}/item"

      item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item["id"]).to eq(Item.first.id)

    end
  end
end
