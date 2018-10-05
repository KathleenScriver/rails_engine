class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  default_scope { order :id }

  def self.most_revenue(quantity)
    unscoped
     .joins(invoices: :transactions)
     .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
     .merge(Transaction.unscoped.success)
     .group(:id)
     .order("revenue desc")
     .limit(quantity)
  end
end
