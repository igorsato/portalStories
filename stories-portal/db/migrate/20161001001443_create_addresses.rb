class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :type_address
      t.string :street
      t.string :number
      t.string :postal_code
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :country
      t.string :complement
      t.string :reference
      t.references :customer, index: true, foreign_key: true

      t.timestamps
    end
  end
end
