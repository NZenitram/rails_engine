class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :invoices
  has_many :transactions, through: :invoices
end
