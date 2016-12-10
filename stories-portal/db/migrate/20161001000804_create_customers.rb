class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :lastname
      t.string :username
      t.string :email
      t.string :cpf

      t.timestamps
    end
  end
end
