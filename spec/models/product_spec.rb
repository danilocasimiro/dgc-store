# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  subject(:product) { build(:product) }

  describe 'associations' do
    it { is_expected.to belong_to(:product_type) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:stock) }

    it 'validates that price is greater than or equal to 0' do
      product.price = -10
      expect(product).not_to be_valid

      product.price = 0
      expect(product).to be_valid

      product.price = 10
      expect(product).to be_valid
    end
  end
end
