class AddCompanyToProductSimple < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_simples, :company, foreign_key: true
  end
end
