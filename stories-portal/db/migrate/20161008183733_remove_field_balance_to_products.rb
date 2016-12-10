class RemoveFieldBalanceToProducts < ActiveRecord::Migration[5.0]
  def change
  	remove_column :products, :balance, :decimal
  	add_column :products, :balance, :integer
  end
end
