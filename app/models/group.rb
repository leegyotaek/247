class Group < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :member , class_name:"User"
end
