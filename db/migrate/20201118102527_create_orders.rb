class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :address
      t.string :phone
      t.string :name
      t.boolean :takeaway
      t.datetime :takeaway_time
      t.references :user, null: false, foreign_key: true
      t.integer :price
      t.string :coupon

      t.timestamps
    end
  end
end
