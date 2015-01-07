class CreateStudTeachRelationships < ActiveRecord::Migration
  def change
    create_table :stud_teach_relationships do |t|

     t.integer :student_id
     t.integer :teacher_id
     t.timestamps null: false
    end

    add_index :stud_teach_relationships, :student_id
    add_index :stud_teach_relationships, :teacher_id
    add_index :stud_teach_relationships, [:student_id, :teacher_id], unique: true

  end
end
