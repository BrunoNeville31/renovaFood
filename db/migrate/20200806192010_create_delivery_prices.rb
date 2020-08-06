class CreateDeliveryPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_prices do |t|
      t.string :bairro_nome
      t.float :valor
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
