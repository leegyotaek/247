class RenameColumnToRelationships < ActiveRecord::Migration
  def change
  rename_column :relationships , :followed_id , :matched_id
  rename_column :relationships , :follower_id , :matcher_id

  end
end
