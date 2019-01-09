# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :items, through: :categorizations

  validates :name, presence: true
  validates :description, presence: true
end
