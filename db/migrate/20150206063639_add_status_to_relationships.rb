class AddStatusToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :status, :string , default: "pending"
    add_index :relationships, :status
  end
end
