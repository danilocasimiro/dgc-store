# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.bigint :owner_id, null: false

      t.timestamps
    end
  end
end
