class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :nome
      t.string :descricao
      t.float :valor, default: 0.0
      t.float :valor_promocional, default: 0.0
      t.boolean :promocao_ativa, default: false
      t.integer :tempo_preparo
      t.integer :estoque_atual
      t.integer :estoque_min
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
