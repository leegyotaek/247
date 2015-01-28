class RenameColumnToUsers < ActiveRecord::Migration
  def change

  rename_column :users , :contury, :country
  end
end
