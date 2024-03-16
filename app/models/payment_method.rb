class PaymentMethod < ApplicationRecord
  validates_presence_of :name

  has_many :orders, inverse_of: :payment_method
end
