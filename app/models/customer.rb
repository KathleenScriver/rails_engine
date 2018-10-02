class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name
  has_many :invoices
  has_many :merchants, through: :invoices

  def self.favorite_merchant(customer_id)
            find(customer_id)
            .merchants.select("merchants.*, count(transactions.id) as transaction_count")
            .joins(invoices: :transactions)
            .where("transactions.result = ?", "success")
            .group("merchants.id")
            .order("transaction_count desc")
            .limit(1)
            .first
  end
end
