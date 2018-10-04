class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :customers, through: :invoices
  default_scope { order :id }

  def self.most_revenue(number)
    unscoped.joins(invoices: [:invoice_items, :transactions])
     .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
     .merge(Transaction.unscoped.success)
     .where(transactions: {result: "success"})
     .group(:id)
     .order("revenue desc")
     .limit(number)
  end

  def self.most_items(number)
    unscoped.joins(invoices: [:invoice_items, :transactions])
     .select("merchants.*, sum(invoice_items.quantity) as total_items")
     .merge(Transaction.unscoped.success)
     .where(transactions: {result: "success"})
     .group(:id)
     .order("total_items desc")
     .limit(number)
  end
end
