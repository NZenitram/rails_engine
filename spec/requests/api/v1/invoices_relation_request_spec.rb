require 'rails_helper'

describe 'invoice endpoint' do
  before(:each) do
    create(:customer)
    create(:merchant)
  end
  context 'GET transactions associated with invoice' do
    it 'returns a list of all transactions' do
      create_list(:invoice, 3, customer_id: Customer.first.id, merchant_id: Merchant.first.id)

      get "/api/v1/invoices/#{Invoice.first.id}/transactions"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
end
