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

class Categorization < ApplicationRecord
  belongs_to :item
  belongs_to :category
end
