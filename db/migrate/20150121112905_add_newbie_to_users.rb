class AddNewbieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newbie, :boolean , default:true
  end
end
