class Meeting < ActiveRecord::Base
  belongs_to :user
  validates :user_id , presence: :true
  validates :name, presence: :true


  has_many :groups , dependent: :destroy
  has_many :members , through: :groups

  mount_uploader :intro_img, PictureUploader
  validate :picture_size






private

 # Validates the size of an uploaded picture.
    def picture_size
      if intro_img.size > 5.megabytes
        errors.add(:intro_img, "should be less than 5MB")
      end
    end


end
