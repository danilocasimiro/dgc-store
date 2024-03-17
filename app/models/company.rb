class Company < ApplicationRecord
  validates_presence_of :owner_id

  has_many :orders, inverse_of: :company
  has_many :product_types, inverse_of: :company
end
