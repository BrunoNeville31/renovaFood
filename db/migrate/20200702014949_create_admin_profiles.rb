class CreateAdminProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_profiles do |t|
      t.string :licenca
      t.string :nome
      t.string :sobrenome
      t.references :admin, foreign_key: true
      t.string :fone

      t.timestamps
    end
  end
end
