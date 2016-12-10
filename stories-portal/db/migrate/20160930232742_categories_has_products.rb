class CategoriesHasProducts < ActiveRecord::Migration[5.0]
  def change
  	create_table :categories_has_products, id: false do |t|
  		t.references :product
  		t.references :category
  	end
  end
end
