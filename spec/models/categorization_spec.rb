# frozen_string_literal: true

# == Schema Information
#
# Table name: categorizations
#
#  id          :bigint(8)        not null, primary key
#  item_id     :bigint(8)        not null
#  category_id :bigint(8)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:item_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:category_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  context 'when testing associations' do
    it { is_expected.to belong_to(:item) }
    it { is_expected.to belong_to(:category) }
  end

  context 'when destroying a categorization' do
    it "doesn't destroy its category upon destruction" do
      categorization = create(:categorization)
      expect { categorization.destroy }.not_to change(Category, :count)
    end

    it "doesn't destroy its item upon destruction" do
      categorization = create(:categorization)
      expect { categorization.destroy }.not_to change(Item, :count)
    end
  end
end
