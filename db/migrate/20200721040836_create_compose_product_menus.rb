class CreateComposeProductMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :compose_product_menus do |t|
      t.references :product, foreign_key: true
      t.references :product_simple, foreign_key: true
      t.integer :qtd

      t.timestamps
    end
  end
end
