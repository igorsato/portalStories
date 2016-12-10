class AddMainAddressToAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :main_address, :boolean, default: false, after: :customer_id
  end
end
