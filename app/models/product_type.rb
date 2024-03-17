class ProductType < ApplicationRecord
  belongs_to :company, inverse_of: :product_types

  has_many :products, inverse_of: :product_type

  validates_presence_of :name

  validates_uniqueness_of :name,
                          scope: :company_id,
                          uniqueness: { case_sensitive: false }

  scope :with_company_id, ->(company_id) { where(company_id:) }
end
