class RenameColumnToLanguages < ActiveRecord::Migration
  def change
  rename_column :languages, :name , :language
  end
end
