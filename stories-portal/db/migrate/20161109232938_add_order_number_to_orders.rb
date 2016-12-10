class AddOrderNumberToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_number, :integer, limit: 8, after: :customer_id
  end
end
