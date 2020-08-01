class CreateProductSimples < ActiveRecord::Migration[5.2]
  def change
    create_table :product_simples do |t|
      t.string :nome
      t.decimal :valor, precision: 5, scale: 2, null: false, default: 0
      t.integer :estoque_min
      t.integer :estoque_atual

      t.timestamps
    end
  end
end
