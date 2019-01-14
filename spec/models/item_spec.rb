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
#  name                :string
#

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database of Item' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(default: 0) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  context 'when testing validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:original_price) }
    it { is_expected.to validate_numericality_of(:discount_percentage).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
  end

  context 'when testing associations' do
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:categorizations) }
  end

  context 'when destroying an item' do
    let(:item) { create(:item) }

    it 'destroys its categorizations upon destruction' do
      create_list(:categorization, 4, item: item)
      expect { item.destroy }.to change(Categorization, :count).from(item.categorizations.count).to(0)
    end

    it "doesn't destroy its category upon destruction" do
      create_list(:categorization, 4, item: item)
      expect { item.destroy }.not_to change(Category, :count)
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

    describe "when price is a float" do
      subject(:item) { build(:item) }

      it { expect(item.price.class).to be(Float) }
    end

    describe "Method average_prices" do
      it 'gives the average price with different items' do
        create(:item_without_discount, original_price: 20)
        create(:item_without_discount, original_price: 10)
        expect(Item.average_price).to eq(15.0)
      end
    end

    context "when database is not empty" do
      subject(:prout) { described_class }

      let!(:item) { create(:item) }

      it { expect(prout.average_price.class).to be(Float) }
      it { expect(prout.average_price).to eq(item.price) }
    end

    context "when database is empty average price is nil" do
      subject(:prout) { described_class }

      it { expect(prout.average_price).to eq(nil) }
    end
  end

  describe 'Has discount' do
    it "can update has_discount to true" do
      item = build(:item_without_discount)

      expect{ item.update_discount }.to change { item.has_discount }.from(false).to(true)
    end
  end
end
