FactoryGirl.define do
  factory :invoice_item do
    item
    invoice
    quantity 5
    unit_price 1234
  end
end
