# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductType do
  subject(:product_type) { build(:product_type) }

  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:products) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it do
      is_expected.to validate_uniqueness_of(:name)
        .scoped_to(:company_id).case_insensitive
    end
  end

  describe '.with_company_id' do
    let(:company_id) { 1 }
    let(:company) { create(:company, id: company_id) }

    it 'returns records associated with the specified company_id' do
      record = create(:product_type, company:)

      expect(described_class.with_company_id(company_id)).to include(record)
    end

    it 'does not return records associated with other company_id' do
      record = create(:product_type)

      expect(described_class.with_company_id(company_id)).not_to include(record)
    end
  end
end
