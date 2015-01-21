class ChangeLanguages < ActiveRecord::Migration
  def change
  change_table :languages do |t| 
  t.remove :type
  t.string :sort
  end
  add_index :languages, :sort
  end
end
