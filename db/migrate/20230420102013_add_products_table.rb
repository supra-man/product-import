class AddProductsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name,
               t.timestamps
    end
  end
end
