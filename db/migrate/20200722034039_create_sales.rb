class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :company, foreign_key: true
      t.string :numero_pedido
      t.integer :status
      t.integer :status_entrega
      t.integer :status_pagamento
      t.string :obs

      t.timestamps
    end
  end
end
