class DropOrderHasProducts < ActiveRecord::Migration[5.0]
  def change
    drop_table :order_has_products
  end
end
