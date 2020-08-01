class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :nome
      t.string :descricao
      t.decimal :valor, precision: 5, scale: 2, null: false, default: 0
      t.decimal :valor_promocional, precision: 5, scale: 2, null: false, default: 0
      t.boolean :promocao_ativa, default: false
      t.string :img_1
      t.string :img_2
      t.string :img_3
      t.integer :estoque_atual
      t.integer :estoque_min
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
