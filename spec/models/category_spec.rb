# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:description).of_type(:text).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context 'when testing validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end

  context 'when testing associations' do
    it { is_expected.to have_many(:items) }
    it { is_expected.to have_many(:categorizations) }
  end

  context 'when destroying a category' do
    let(:category) { create(:category) }

    it 'destroys its categorizations upon destruction' do
      create_list(:categorization, 4, category: category)
      expect { category.destroy }.to change(Categorization, :count).from(category.categorizations.count).to(0)
    end

    it "doesn't destroy its items upon destruction" do
      create_list(:categorization, 4, category: category)
      expect { category.destroy }.not_to change(Item, :count)
    end
  end
end
