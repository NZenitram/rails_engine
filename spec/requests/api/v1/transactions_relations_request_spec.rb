require 'rails_helper'

describe 'transactions endpoint' do

  context 'GET invoice returns invoices associated with a transaction' do
    it 'returns a list of invoices' do
      create_list(:merchant, 3)
      create(:customer)
      create(:invoice, merchant_id: Merchant.first.id, customer_id: Customer.first.id)
      create_list(:transaction, 3, invoice_id: Invoice.first.id )

      get "/api/v1/transactions/#{Transaction.first.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice["merchant_id"]).to eq(Merchant.first.id)
    end
  end
end
