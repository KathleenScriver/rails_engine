class Transaction < ApplicationRecord
  belongs_to :invoice
  default_scope { order :id }
  scope :success, -> { where(result: 'success') }
end
