class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.boolean :status
      t.string :size, array: true
      t.timestamps
    end
  end
end
