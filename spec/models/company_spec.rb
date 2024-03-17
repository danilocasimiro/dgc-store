# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company do
  subject(:company) { build(:company) }

  describe 'associations' do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:product_types) }
  end

  describe 'validations' do
    before do
      create(:company, owner_id: '1')
    end

    it 'validates case-insensitive uniqueness of owner_id' do
      company_duplicate = build(:company, owner_id: '1')

      expect(company_duplicate).to be_invalid
      expect(company_duplicate.errors[:owner_id])
        .to include('has already been taken')
    end
    it do
      is_expected.to validate_uniqueness_of(:owner_id)
    end
  end
end
