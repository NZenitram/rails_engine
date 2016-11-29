class InvoiceItem < ApplicationRecord
  has_many :invoices
  has_many :items
end
