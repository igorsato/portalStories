class AddressToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :address, foreign_key: true, index: true, after: :customer_id    
  end
end
