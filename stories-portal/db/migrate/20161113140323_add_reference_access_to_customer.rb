class AddReferenceAccessToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_reference :customers, :access, foreign_key: true, index: true, after: :cpf
    add_column :customers, :active, :boolean, after: :access_id
  end
end
