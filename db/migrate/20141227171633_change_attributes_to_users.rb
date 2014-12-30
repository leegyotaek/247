class ChangeAttributesToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  t.remove :remeber_digest
  t.string :remember_digest
end
  end
end
