class CreateSides < ActiveRecord::Migration[5.2]
  def change
    create_table :sides do |t|
      t.string :nome
      t.string :valor
      t.string :limite
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
