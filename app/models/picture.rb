class Picture < ActiveRecord::Base 
 belongs_to :imageable, polymorphic: true
 validates :name, presence:true
 validates :imageable_id, presence:true
 validates :imageable_type, presence:true
 validate :picture_size


 mount_uploader :name, PictureUploader 
 crop_uploaded :name
 
 private

  def picture_size
  	if name.size > 5.megabytes
  		errors.add(:name, "5MB를 초과할 수 없습니다.")
  	end
  	
  end


end
