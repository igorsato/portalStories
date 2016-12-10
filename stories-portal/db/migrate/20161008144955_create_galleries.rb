class CreateGalleries < ActiveRecord::Migration[5.0]
  def change
    create_table :galleries do |t|
      t.text :description
      t.references :attachable, polymorphic: true, index: true
      t.attachment :media
      t.boolean :active

      t.timestamps
    end
  end
end
