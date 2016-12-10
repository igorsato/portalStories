class AddAliasToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :alias, :string
  end
end
