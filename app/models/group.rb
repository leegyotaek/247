class Group < ActiveRecord::Base
  belongs_to :meeting, counter_cache: :members_count
  belongs_to :member , class_name:"User"
end
