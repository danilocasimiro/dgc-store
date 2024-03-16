# frozen_string_literal: true

class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_methods do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
