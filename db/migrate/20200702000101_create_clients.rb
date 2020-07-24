class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :nome
      t.string :fone
      t.string :cpf
      t.string :email
      t.string :rua
      t.string :numero
      t.string :cidade
      t.string :estado
      t.string :cep
      t.string :complemento
      t.boolean :status, default: true
      t.date :aniversario

      t.timestamps
    end
  end
end
