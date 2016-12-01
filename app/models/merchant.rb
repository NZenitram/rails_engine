class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def total_revenue(date = nil)
    invoices.joins(:transactions, :invoice_items)
      .where(transactions: {result: "success"})
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
