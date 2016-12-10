class AddTableProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :description_short
      t.string :sku, null: false
      t.boolean :featured, default: false
      t.boolean :active, default: false
      t.decimal :cost_price, precision: 12, scale: 2, default: 0.0
      t.decimal :sale_price, precision: 12, scale: 2, default: 0.0, null: false
      t.decimal :promotional_price, precision: 12, scale: 2, default: 0.0

      #sobre os dados de correios
      t.decimal :weight, precision: 12, scale: 2, default: 0.0, null: false #peso
      t.decimal :height, precision: 12, scale: 2, default: 0.0, null: false #altura
      t.decimal :width, precision: 12, scale: 2, default: 0.0, null: false #largura
      t.decimal :depth, precision: 12, scale: 2, default: 0.0, null: false #profundidade
      t.decimal :balance, precision: 12, scale: 2, default: 0.0 #saldo 

      t.timestamps
    end
  end
end
