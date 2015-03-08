class Picture < ActiveRecord::Base 
 belongs_to :imageable, polymorphic: true
 validates :name, presence:true
 validates :imageable_id, presence:true
 validates :imageable_type, presence:true
 validate :picture_size
 after_update :crop_picture
  

 mount_uploader :name, PictureUploader 
 #crop_uploaded :picture
 attr_accessor :picture_crop_x, :picture_crop_y, :picture_crop_w, :picture_crop_h


 private


 def crop_picture
    name.recreate_versions! if picture_crop_x.present?
  end


  def picture_size
  	if name.size > 5.megabytes
  		errors.add(:name, "5MB를 초과할 수 없습니다.")
  	end
  	
  end


end
