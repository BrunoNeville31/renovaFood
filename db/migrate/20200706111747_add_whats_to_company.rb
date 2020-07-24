class AddWhatsToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :venda_bot, :boolean, default: false
  end
end
