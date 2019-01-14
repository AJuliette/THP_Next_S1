# frozen_string_literal: true

class CreateCategorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :categorizations do |t|
      t.belongs_to :item, index: true, null: false
      t.belongs_to :category, index: true, null: false

      t.timestamps
    end
  end
end
