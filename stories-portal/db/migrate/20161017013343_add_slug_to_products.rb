class AddSlugToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :slug, :string, after: :depth
  end
end
