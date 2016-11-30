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
  context "GET a transaction by ID" do
    it "returns the transaction" do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find?id=#{Transaction.first.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.first[1]).to eq(Transaction.first.id)
    end
  end

  context "GET a transaction by invoice_id" do
    it "returns the transaction" do
      create(:transaction, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find?invoice_id=#{Transaction.first.invoice_id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.first[1]).to eq(Transaction.first.id)
    end
  end

  context "GET a transaction by credit_card_number" do
    it "returns the transaction" do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find?credit_card_number=#{Transaction.first.credit_card_number}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.first[1]).to eq(Transaction.first.id)
    end
  end

  context "GET a transaction by result" do
    it "returns the transaction" do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find?result=#{Transaction.first.result}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.first[1]).to eq(Transaction.first.id)
    end
  end

  context "GET all transactions by id" do
    it "returns the transactions" do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find_all?id=#{Transaction.first.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction[0]["id"]).to eq(Transaction.first.id)
    end
  end

  context "GET all transactions by invoice_id" do
    it "returns the transactions" do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find_all?invoice_id=#{Transaction.first.invoice_id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.count).to eq(3)
    end
  end

  context "GET all transactions by created_at" do
    xit "returns the transactions" do
      create_list(:transaction, 3, invoice_id: Invoice.first.id)

      get "/api/v1/transactions/find_all?created_at=#{Transaction.first.created_at}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.count).to eq(3)
    end
  end

  # context "GET all merchants by params" do
  #   it "returns the merchants" do
  #     create_list(:transaction, 3, invoice_id: Invoice.first.id)
  #
  #     get "/api/v1/merchants/find_all?id=#{Transaction.first.updated_at}"
  #
  #     transaction = JSON.parse(response.body)
  #
  #     expect(response).to be_success
  #     expect(transaction.count).to eq(3)
  #   end
  # end
end
