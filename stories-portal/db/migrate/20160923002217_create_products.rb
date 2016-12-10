class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :description_short
      t.integer :sku
      t.boolean :featured
      t.boolean :active
      t.decimal :cost_price, precision: 12, scale: 2
      t.decimal :sale_price, precision: 12, scale: 2
      t.decimal :promotional_price, precision: 12, scale: 2

      #sobre os dados de correios
      t.string :weight #peso
      t.string :height #altura
      t.string :width #largura
      t.string :depth #profundidade
      t.string :balance #saldo 
      t.timestamps
    end
  end
end
