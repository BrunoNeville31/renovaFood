class CreateSaleProductDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_product_details do |t|
      t.references :sale_product, foreign_key: true
      t.references :side_product_step, foreign_key: true
      t.string :valor_adicional

      t.timestamps
    end
  end
end
