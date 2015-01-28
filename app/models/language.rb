class Language < ActiveRecord::Base
  belongs_to :user
  validates :language , presence: :true
  validates :level , presence: :true , numericality: { only_integer: true }



 
end
