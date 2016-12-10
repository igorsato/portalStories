class RemoveFieldsToAddress < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses, :state, :string
  end
end
