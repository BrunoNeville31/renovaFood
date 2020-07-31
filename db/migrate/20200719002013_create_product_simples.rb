class CreateProductSimples < ActiveRecord::Migration[5.2]
  def change
    create_table :product_simples do |t|
      t.string :nome
      t.integer :valor_cents
      t.integer :estoque_min
      t.integer :estoque_atual

      t.timestamps
    end
  end
end
