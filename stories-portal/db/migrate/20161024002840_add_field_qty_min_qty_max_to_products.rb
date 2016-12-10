class AddFieldQtyMinQtyMaxToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :qty_min_in_cart, :integer, default: 1
    add_column :products, :qty_max_in_cart, :integer
  end
end
