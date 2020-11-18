class CreateCoupons < ActiveRecord::Migration[6.0]
  def change
    create_table :coupons do |t|
      t.integer :discount
      t.string :code
      t.date :enddate
      t.date :startdate

      t.timestamps
    end
  end
end
