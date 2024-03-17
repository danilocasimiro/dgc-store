class Product < ApplicationRecord
  belongs_to :product_type, inverse_of: :products

  validates_presence_of :name, :price, :stock

  enum status: %i[active inactive]

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: Product.statuses.keys }
end
