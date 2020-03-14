class CreateOrdenatedOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :ordenated_order_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :layer
      t.integer :quantity

      t.timestamps
    end
  end
end
