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

  def self.revenue_by_date(date)
    Invoice.unscoped
     .joins(:transactions, :invoice_items)
     .select("invoices.created_at, invoice_items.quantity, invoice_items.unit_price")
     .merge(Transaction.unscoped.success)
     .where(created_at: (date.to_datetime.beginning_of_day..date.to_datetime.end_of_day))
     .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.single_revenue(id)
     find(id).invoices
      .joins(:transactions, :invoice_items)
      .select("invoices.id, invoice_items.quantity, invoice_items.unit_price")
      .merge(Transaction.unscoped.success)
      .sum("invoice_items.quantity * invoice_items.unit_price")
  end
end
