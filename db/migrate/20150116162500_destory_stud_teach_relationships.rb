class DestoryStudTeachRelationships < ActiveRecord::Migration
  def change
  drop_table :stud_teach_relationships
  end
end
