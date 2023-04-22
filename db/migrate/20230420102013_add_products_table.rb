# frozen_string_literal: true

class AddProductsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :code, null: false, index: { unique: true }
      t.string :name,
               t.timestamps
    end
  end
end
