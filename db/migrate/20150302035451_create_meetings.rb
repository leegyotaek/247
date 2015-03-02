class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :user, index: true
      t.string :name
      t.integer :members_count

      t.timestamps null: false
    end
    add_foreign_key :meetings, :users
  end
end
