class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :customers, through: :invoices

  def self.most_revenue(number)
    joins(invoices: :invoice_items)
     .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
     .group(:id)
     .order("revenue desc")
     .limit(number)
  end

  def self.most_items(number)
    joins(invoices: :invoice_items)
     .select("merchants.*, sum(invoice_items.quantity) as total_items")
     .group(:id)
     .order("total_items desc")
     .limit(number)
  end
end
