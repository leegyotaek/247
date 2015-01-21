class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.integer :level
      t.string :type
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :languages, :users
  end
end
