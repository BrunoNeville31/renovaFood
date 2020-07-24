class AddImgToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :src, :string
  end
end
