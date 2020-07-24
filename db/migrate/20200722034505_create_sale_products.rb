class CreateSaleProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :sale_products do |t|
      t.references :sale, foreign_key: true
      t.references :product, foreign_key: true
      t.string :valor

      t.timestamps
    end
  end
end
