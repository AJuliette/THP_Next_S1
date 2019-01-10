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

class Item < ApplicationRecord
  before_update :discount_to_true

  has_many :categorizations, dependent: :destroy
  has_many :categories, -> { distinct }, through: :categorizations

  validates :original_price, presence: true
  validates :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :name, presence: true

  scope :alphabetical_order, -> { order(name: :asc) }

  def price
    original_price unless has_discount
    (original_price * (1 - (discount_percentage.to_f / 100))).round(2)
  end

  def self.average_price
    sum = 0
    Item.all.find_each do |i|
      sum += i.price
    end
    sum / Item.count
  end

  def discount_to_true
    self.has_discount = true
  end
end
