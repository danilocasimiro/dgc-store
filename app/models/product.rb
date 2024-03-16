class Product < ApplicationRecord
  belongs_to :product_type, inverse_of: :products

  validates_presence_of :name, :price, :stock

  enum status: %i[active inactive]

  validates :status, inclusion: { in: Product.statuses.keys }
end
