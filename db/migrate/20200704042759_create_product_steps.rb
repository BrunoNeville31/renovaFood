class CreateProductSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :product_steps do |t|
      t.text :descricao
      t.references :product, foreign_key: true
      t.integer :limite
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
