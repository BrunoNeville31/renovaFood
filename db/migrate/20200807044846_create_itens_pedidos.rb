class CreateItensPedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :itens_pedidos do |t|
      t.references :pedido, foreign_key: true
      t.string :adicional_nome
      t.integer :adicional_id
      t.string :valor
      t.integer :qtd_adicional

      t.timestamps
    end
  end
end
