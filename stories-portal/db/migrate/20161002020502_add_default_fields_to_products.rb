class AddDefaultFieldsToProducts < ActiveRecord::Migration[5.0]
  def change
  	change_column :products, :active, :boolean, default: false
  	change_column :products, :featured, :boolean, default: false
  end
end
