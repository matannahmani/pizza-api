class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.boolean :open
      t.boolean :delivery
      t.boolean :takeaway

      t.timestamps
    end
  end
end
