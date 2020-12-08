class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :phone
      t.string :name
      t.boolean :takeaway
      t.integer :price
      t.string :coupon

      t.timestamps
    end
  end
end
