class OrderHasProducts < ActiveRecord::Migration[5.0]
  def change
  	create_table :order_has_products, id: false do |t|
  		t.references :product
  		t.references :order
  	end  	
  end
end
