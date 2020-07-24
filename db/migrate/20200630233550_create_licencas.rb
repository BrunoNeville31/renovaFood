class CreateLicencas < ActiveRecord::Migration[5.2]
  def change
    create_table :licencas do |t|
      t.string :numero
      t.integer :qtd_empresa
      t.integer :status

      t.timestamps
    end
  end
end
