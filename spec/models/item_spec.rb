# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end

    context "when the item doesn't have a discount" do
      let(:item) { build(:item_without_discount, original_price: 100.00) }

      it { expect(item.price).to eq(100.00) }
    end

    it { is_expected.to validate_presence_of(:original_price) }

    it "can't have a negative discount" do
      item = FactoryBot.build(:item_with_discount, discount_percentage: -1)
      expect(item).not_to be_valid
    end

    it "can't have a discout percentage above 100" do
      item = FactoryBot.build(:item_with_discount, discount_percentage: 101)
      expect(item).not_to be_valid
    end

    it 'gives the average price' do
      FactoryBot.create(:item_without_discount, original_price: 20)
      FactoryBot.create(:item_without_discount, original_price: 10)
      expect(Item.average_price).to eq(15.0)
    end
  end
end
