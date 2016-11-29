FactoryGirl.define do
  factory :transaction do
    credit_card_number 1234567890
    credit_card_expiration_date Date.today
    result "success"

  end
end
