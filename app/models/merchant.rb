class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  def total_revenue(date = nil)
    if date
     invoices.joins(:invoice_items, :transactions).merge(Transaction.successful).where(created_at: date).sum("invoice_items.quantity * invoice_items.unit_price")
   else
     invoices.joins(:transactions, :invoice_items).merge(Transaction.successful).sum("invoice_items.quantity * invoice_items.unit_price")
   end
 end

  def self.most_items(num)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful).group(:id)
      .order("sum(invoice_items.quantity) DESC").limit(num)
  end

  def favorite_customer
    customers.joins(:transactions).merge(Transaction.successful).group(:id).order("count(customers.id) DESC").first
  end

  def self.top_revenue(quantity)
    joins(:transactions, :invoice_items).group(:id).order("sum(invoice_items.quantity * invoice_items.unit_price) DESC").limit(quantity)
  end

  def self.revenue_by_date(date)
     joins(invoices: [:invoice_items, :transactions]).merge(Transaction.successful).where(invoices: {created_at: date}).sum("invoice_items.quantity * invoice_items.unit_price")
  end
end




















#
