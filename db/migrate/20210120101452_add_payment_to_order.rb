class AddPaymentToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :processId, :integer
    add_column :orders, :processToken, :string
    add_column :orders, :url, :string
  end
end
