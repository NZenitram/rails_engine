require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'returns items by revenue' do
    create_list(:item, 3)
    create_list(:invoice, 3)
    create(:transaction, result: 'success', invoice_id: Invoice.first.id)
    create(:transaction, result: 'success', invoice_id: Invoice.last.id)
    create(:invoice_item, invoice_id: Invoice.first.id, item_id: Item.first.id, quantity: 15, unit_price: 5)
    create(:invoice_item, invoice_id: Invoice.second.id, item_id: Item.first.id, quantity: 15, unit_price: 5)
    create(:invoice_item, invoice_id: Invoice.last.id, item_id: Item.last.id, quantity: 12, unit_price: 2)

    items = Item.most_revenue(2)

    expect(items.count).to eq(2)
  end

  it 'returns items by revenue' do
    create_list(:item, 3)
    create_list(:invoice, 3)
    create(:transaction, result: 'success', invoice_id: Invoice.first.id)
    create(:transaction, result: 'success', invoice_id: Invoice.last.id)
    create(:invoice_item, invoice_id: Invoice.first.id, item_id: Item.first.id, quantity: 15, unit_price: 5)
    create(:invoice_item, invoice_id: Invoice.last.id, item_id: Item.last.id, quantity: 12, unit_price: 2)
    create(:invoice_item, invoice_id: Invoice.last.id, item_id: Item.second.id, quantity: 1, unit_price: 2)

    items = Item.most_items(2)

    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(Item.first.id)
  end
end
