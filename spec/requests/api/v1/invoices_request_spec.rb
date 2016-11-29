require 'rails_helper'

describe 'invoice endpoint' do
  before(:each) do
    create(:customer)
    create(:merchant)
  end
  context 'GET invoices' do
    it 'returns a list of all invoices' do
      create_list(:invoice, 3, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end

  context 'GET a invoice' do
    it 'returns an invoice' do
      create_list(:invoice, 3, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
      get "/api/v1/invoices/#{Invoice.first.id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice.first[1]).to eq(Invoice.first.id)
    end
  end

  context 'GET a invoice by parameter' do
    it 'returns and invoice' do
      create_list(:invoice, 3, customer_id: Customer.first.id, merchant_id: Merchant.first.id)

      get "/api/v1/invoices/find?id=#{Invoice.first.id}"

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.first[1]).to eq(Invoice.first.id)
    end
  end

  context 'GET invoices by attribute' do
    it 'returns invoices' do
      create_list(:invoice, 3, customer_id: Customer.first.id, merchant_id: Merchant.first.id)

      get '/api/v1/invoices/find_all?status=shipped'

      invoices = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoices.count).to eq(3)
    end
  end
end
