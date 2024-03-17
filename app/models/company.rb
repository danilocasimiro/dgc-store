class Company < ApplicationRecord
  validates_presence_of :owner_id

  validates :owner_id, uniqueness: { case_sensitive: false }

  has_many :orders, inverse_of: :company
  has_many :product_types, inverse_of: :company
end
