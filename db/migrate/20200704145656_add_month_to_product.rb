class AddMonthToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :monday, :boolean, default: true
    add_column :products, :tuesday, :boolean, default: true
    add_column :products, :wednesday, :boolean, default: true
    add_column :products, :thursday, :boolean, default: true
    add_column :products, :friday, :boolean, default: true
    add_column :products, :saturday, :boolean, default: true
    add_column :products, :sunday, :boolean, default: true
  end
end
