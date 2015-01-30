class AddnMatchingColumnToUsers < ActiveRecord::Migration
  def change
  add_column :users , :matching_lan , :string
  add_column :users , :matching_age_from , :integer
  add_column :users , :matching_age_to , :integer
  add_column :users , :matching_interest , :string
  end
  
end
