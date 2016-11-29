require 'rails_helper'

describe 'transaction endpoint' do
  before(:each) do
    create_list(:customer, 1)
    create_list(:merchant, 1)
    FactoryGirl.create(:invoice, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
  end
  context 'GET transactions' do
    it 'returns a list of all transactions' do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)
      get '/api/v1/transactions'

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end
  #
  context 'GET a transaction' do
    it 'returns a transaction' do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)
      get "/api/v1/transactions/#{Transaction.first.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.first[1]).to eq(Transaction.first.id)
    end
  end
end
