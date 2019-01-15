# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  name                :string           not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ApplicationRecord
  after_update :update_discount

  has_many :categorizations, dependent: :destroy
  has_many :categories, -> { distinct }, through: :categorizations

  validates :original_price, presence: true
  validates :discount_percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :name, presence: true

  scope :alphabetical_order, -> { order(name: :asc) }
  scope :has_discount, -> { where has_discount: true }
  scope :no_discount, -> { where has_discount: false }

  def price
    original_price unless has_discount
    (original_price * (1 - (discount_percentage.to_f / 100))).round(2)
  end

  def self.average_price
    if count.zero?
      nil
    else
      sum = 0
      all.find_each do |i|
        sum += i.price
      end
      sum / count
    end
  end

  def update_discount
    self.has_discount = true
    save
  end
end
