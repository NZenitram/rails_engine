require 'rails_helper'

describe 'merchant endpoint' do

  context 'GET items returns items associated with a merchant' do
    it 'returns a list of items' do
      create_list(:merchant, 3)
      create_list(:item, 4, merchant_id: Merchant.first.id)

      get "/api/v1/merchants/#{Merchant.first.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(4)
    end
  end

  context 'GET invoices returns invoices associated with a merchant' do
    it 'returns a list of invoices' do
      create_list(:merchant, 3)
      create(:customer)
      create_list(:invoice, 5, merchant_id: Merchant.first.id, customer_id: Customer.first.id)

      get "/api/v1/merchants/#{Merchant.first.id}/invoices"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(5)
    end
  end
end
