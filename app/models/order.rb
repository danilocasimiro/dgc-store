class Order < ApplicationRecord
  belongs_to :client, inverse_of: :orders

  has_one :company, inverse_of: :orders
  has_one :payment_method, inverse_of: :orders
end
