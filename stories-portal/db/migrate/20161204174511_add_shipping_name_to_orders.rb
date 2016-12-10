class AddShippingNameToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipping_name, :string, after: :shipping
  end
end
