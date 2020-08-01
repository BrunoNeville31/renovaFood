class CreateProductSimples < ActiveRecord::Migration[5.2]
  def change
    create_table :product_simples do |t|
      t.string :nome
      t.float :valor, default: 0.0
      t.integer :estoque_min
      t.integer :estoque_atual

      t.timestamps
    end
  end
end
