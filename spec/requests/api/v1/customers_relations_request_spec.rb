require 'rails_helper'

describe 'customer endpoint' do

  context 'GET invoices returns invoices associated with a customer' do
    it 'returns a list of invoices' do
      create_list(:merchant, 3)
      create(:customer)
      create_list(:invoice, 5, merchant_id: Merchant.first.id, customer_id: Customer.first.id)

      get "/api/v1/customers/#{Customer.first.id}/invoices"
      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.first["customer_id"]).to eq(Customer.first.id)
    end
  end

  context 'GET transactions associated with a customer' do
    it 'returns a list of all transactions' do
      create_list(:merchant, 3)
      create(:customer)
      create_list(:invoice, 3, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
      create_list(:transaction, 3, invoice_id: Invoice.first.id)


      get "/api/v1/customers/#{Customer.first.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end
end
