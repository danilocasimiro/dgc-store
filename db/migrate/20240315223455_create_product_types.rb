# frozen_string_literal: true

class CreateProductTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :product_types do |t|
      t.references :company, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
