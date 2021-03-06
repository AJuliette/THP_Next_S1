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

class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :items, through: :categorizations

  validates :name, presence: true
  validates :description, presence: true
end
