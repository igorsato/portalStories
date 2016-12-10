class CreateNewsletters < ActiveRecord::Migration[5.0]
  def change
    create_table :newsletters do |t|
      t.string :name
      t.string :email
      t.boolean :active

      t.timestamps
    end
  end
end
