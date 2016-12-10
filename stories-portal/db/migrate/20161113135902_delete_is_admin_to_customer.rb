class DeleteIsAdminToCustomer < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :is_admin, :boolean
  end
end
