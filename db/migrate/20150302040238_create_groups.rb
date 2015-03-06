class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :meeting, index: true
      t.integer :member_id
      t.string :status
      t.string :permission , default: "pending"

      t.timestamps null: false
    end
    add_foreign_key :groups, :meetings
  end
end
