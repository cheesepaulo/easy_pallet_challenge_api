class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :load, null: false, foreign_key: true
      t.string :code
      t.string :bay

      t.timestamps
    end
  end
end
