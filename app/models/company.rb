class Company < ApplicationRecord
  validates_presence_of :owner_id

  has_many :orders, inverse_of: :company
end
