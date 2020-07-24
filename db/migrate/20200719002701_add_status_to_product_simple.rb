class AddStatusToProductSimple < ActiveRecord::Migration[5.2]
  def change
    add_column :product_simples, :status, :boolean, default: true
  end
end
