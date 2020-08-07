class CreateItensAdicionalPedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :itens_adicional_pedidos do |t|
      t.string :nome
      t.integer :insumo_id
      t.references :itens_pedido, foreign_key: true
      t.integer :product_step_id
      t.integer :qtd
      t.decimal :valor_adicional

      t.timestamps
    end
  end
end
