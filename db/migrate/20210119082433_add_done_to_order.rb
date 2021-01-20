class AddDoneToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :done, :boolean, default: false
  end
end
