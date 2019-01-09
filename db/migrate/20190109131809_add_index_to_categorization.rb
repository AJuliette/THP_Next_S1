# frozen_string_literal: true

class AddIndexToCategorization < ActiveRecord::Migration[5.2]
  def change
    add_index :categorizations, %i[item_id category_id], unique: true
  end
end
