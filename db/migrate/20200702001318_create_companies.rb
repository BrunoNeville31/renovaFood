class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :nome
      t.string :rua
      t.string :numero
      t.string :estado
      t.string :cidade
      t.string :cep
      t.string :bairro
      t.string :licenca
      t.references :admin, foreign_key: true
      t.string :cnpj
      t.string :fone
      t.integer :status
      t.string :data_cobranca
      t.string :taxa
      t.string :valor
      t.string :valor_centavos
     

      t.string :moday_open
      t.string :moday_close

      t.string :tuesday_open
      t.string :tuesday_close

      t.string :wednesday_open
      t.string :wednesday_close

      t.string :thursday_open
      t.string :thursday_close

      t.string :friday_open
      t.string :friday_close

      t.string :saturday_open
      t.string :saturday_close

      t.string :sunday_open
      t.string :sunday_close

      t.timestamps
    end
  end
end
