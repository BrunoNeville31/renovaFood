class AddTaxaToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :taxa_entrega, :string
  end
end
