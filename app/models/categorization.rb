# frozen_string_literal: true

class Categorization < ApplicationRecord
  belongs_to :item
  belongs_to :category
end
