class StudTeachRelationship < ActiveRecord::Base
belongs_to :student, class_name:"User"
belongs_to :teacher, class_name:"User"
end
