class CreateSideProductSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :side_product_steps do |t|
      t.string :nome
      t.float :valor, default: 0.0
      t.boolean :valor_padrao, default: true
      t.references :product_step, foreign_key: true
      t.integer :side_id

      t.timestamps
    end
  end
end
