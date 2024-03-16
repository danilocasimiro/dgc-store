class OrderItem < ApplicationRecord
  validates_presence_of :quantity

  belongs_to :order, inverse_of: :order_items
  belongs_to :product, inverse_of: :order_items
end
