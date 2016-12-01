class Item < ApplicationRecord
  belongs_to :merchant

  has_many :invoice_items

  has_many :invoices, {:through=>:invoice_items, :source=>"invoice"}

  def self.most_revenue(num)
    joins(invoices: [:transactions])
      .merge(Transaction.successful).group(:id)
      .order("sum(invoice_items.quantity * invoice_items.unit_price) DESC")
      .first(num)
  end

  def self.most_items(num)
    joins(invoices: [:transactions])
      .merge(Transaction.successful).group(:id)
      .order("sum(invoice_items.quantity * 1) DESC")
      .first(num)
  end

  def best_day
    invoices.joins(:transactions, :invoice_items)
    .where(transactions: {result: "success"}).select("invoices.created_at")
    .group(:created_at).order("sum(invoice_items.quantity) DESC").first.created_at
  end
end
