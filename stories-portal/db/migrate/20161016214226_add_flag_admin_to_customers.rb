class AddFlagAdminToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :is_admin, :boolean, default: false, after: :cpf
  end
end
