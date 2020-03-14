class CreateLoads < ActiveRecord::Migration[6.0]
  def change
    create_table :loads do |t|
      t.string :code
      t.datetime :delivery_date

      t.timestamps
    end
  end
end
