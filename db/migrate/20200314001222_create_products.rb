class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :label
      t.integer :ballast

      t.timestamps
    end
  end
end
