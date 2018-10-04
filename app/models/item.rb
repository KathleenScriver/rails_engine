class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  default_scope { order :id }

  def self.most_revenue(quantity)
    joins(:invoice_items, :invoices)
     .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
     .merge(Invoice.unscoped.with_successful_transactions)
     .group(:id, "invoices.id")
     .order("revenue desc")
     .limit(quantity)
  end
end
