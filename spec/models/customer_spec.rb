require 'rails_helper'

RSpec.describe Customer, type: :model do

  it "can return a favorite_merchant" do
    create_list(:customer, 2)
    create(:merchant)
    create_list(:invoice, 2, customer_id: Customer.first.id, merchant_id: Merchant.first.id)
    create(:invoice, customer_id: Customer.last.id, merchant_id: Merchant.first.id)
    create_list(:transaction, 2, invoice_id: Invoice.first.id )

    merchant = Customer.first.favorite_merchant
    
    expect(merchant.name).to eq(Merchant.first.name)
  end

  it "can return a random customer" do
    create_list(:customer, 2)
    customer = Customer.random
    expect(customer).to be_instance_of(Customer)
  end

end
