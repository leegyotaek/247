class AddIndextToLanguages < ActiveRecord::Migration
  def change
    add_index :languages, :name
    add_index :languages, :type
  end
end
