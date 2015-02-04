class Relationship < ActiveRecord::Base
belongs_to :matcher, class_name:"User"
belongs_to :matched, class_name:"User"


validates :matcher_id , presence: true
validates :matched_id , presence: true

end
