class AddColumnToUsers < ActiveRecord::Migration
  def change

  add_column :users, :gender , :string
  add_column :users, :birthday, :date
  add_column :users, :region, :string
  add_column :users, :contury, :string
  add_column :users, :city, :string
  add_column :users, :introduce, :text
  add_column :users, :interests, :string
  add_column :users, :status , :string

  add_index :users, [:contury, :city] 
  add_index :users, :gender
  end
end
