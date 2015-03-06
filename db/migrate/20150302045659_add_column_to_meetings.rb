class AddColumnToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :max_member, :integer
    add_column :meetings, :introduce, :text
    add_column :meetings, :intro_img, :string
    add_column :meetings, :language, :string
    add_column :meetings, :country, :string
    add_column :meetings, :city, :string
  end
end
