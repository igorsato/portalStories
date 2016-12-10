class DropManagers < ActiveRecord::Migration[5.0]
  def change
    drop_table :managers
  end
end
