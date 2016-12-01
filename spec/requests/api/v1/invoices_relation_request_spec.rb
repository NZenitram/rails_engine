require 'rails_helper'

describe 'invoice endpoint' do
  before(:each) do
    create_list(:customer, 3)
    create_list(:merchant, 3)
  end
  context 'GET transactions associated with invoice' do
    it 'returns a list of all transactions' do
      create_list(:invoice, 3)
      create_list(:transaction, 3, invoice_id: Invoice.first.id)


      get "/api/v1/invoices/#{Invoice.first.id}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(3)
    end
  end

  context 'GET invoice_items associated with invoice' do
    it 'returns a list of all invoice_items' do
      create_list(:invoice, 3)
      create_list(:transaction, 3)
      create_list(:invoice_item, 3, invoice_id: Invoice.first.id)


      get "/api/v1/invoices/#{Invoice.first.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end

  context 'GET items associated with invoice' do
    it 'returns a list of all transactions' do
      create_list(:invoice, 3, merchant_id: Merchant.first.id )
      create_list(:item, 3)
      create_list(:invoice_item, 3, invoice_id: Invoice.first.id, item_id: Item.first.id)


      get "/api/v1/invoices/#{Invoice.first.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
      expect(Invoice.first.merchant_id).to eq(Merchant.first.id)
    end
  end

  context 'GET customers associated with invoice' do
    it 'returns a list of all customers' do
      create_list(:customer, 3)
      create_list(:invoice, 3, customer_id: Customer.first.id)


      get "/api/v1/invoices/#{Invoice.first.id}/customer"

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers["first_name"]).to eq(Customer.first.first_name)
    end
  end

  context 'GET merchants associated with invoice' do
    it 'returns a list of all merchants' do
      create_list(:merchant, 3)
      create_list(:invoice, 3, merchant_id: Merchant.first.id)

      get "/api/v1/invoices/#{Invoice.first.id}/merchant"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants["name"]).to eq(Merchant.first.name)
    end
  end
end
