class AddProductSimpleToSideStep < ActiveRecord::Migration[5.2]
  def change
    remove_column :side_product_steps, :valor_padrao
    remove_column :side_product_steps, :side_id
    add_reference :side_product_steps, :product_simples, foreign_key: true
  end
end
