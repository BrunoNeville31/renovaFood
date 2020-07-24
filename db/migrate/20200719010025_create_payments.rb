class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.boolean :status
      t.string :nome
      t.boolean :parcela
      t.integer :num_parcela
      t.integer :tipo
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
