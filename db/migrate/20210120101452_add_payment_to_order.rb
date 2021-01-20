class AddPaymentToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :url, :string
  end
end
