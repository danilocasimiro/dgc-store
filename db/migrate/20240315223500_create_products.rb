# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :product_type, foreign_key: true
      t.string :name, null: false
      t.decimal :price, null: false
      t.integer :stock, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
