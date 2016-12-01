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
end
