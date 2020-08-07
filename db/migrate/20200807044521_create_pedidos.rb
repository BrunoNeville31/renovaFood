class CreatePedidos < ActiveRecord::Migration[5.2]
  def change
    create_table :pedidos do |t|
      t.string :numero
      t.integer :numero_interno
      t.string :entrega_rua
      t.string :entrega_cidade
      t.string :entrega_complemento
      t.string :entrega_bairro
      t.decimal :taxa_entrega
      t.integer :client_id
      t.decimal :valor_total
      t.integer :status
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
