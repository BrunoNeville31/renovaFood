class AddMondayToCompany < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :moday_open, :string
    remove_column :companies, :moday_close, :string
    add_column :companies, :monday_open, :string
    add_column :companies, :monday_close, :string
  end
end
