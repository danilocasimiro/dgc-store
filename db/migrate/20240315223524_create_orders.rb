# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :client, foreign_key: true
      t.references :company, foreign_key: true
      t.references :payment_method, foreign_key: true

      t.timestamps
    end
  end
end
