class AddReferenceOrderStatusesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :order_status, foreign_key: true, index: true
  end
end
