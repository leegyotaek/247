class Language < ActiveRecord::Base
  belongs_to :user
  validates :name , presence: :true
  validates :level , presence: :true , numericality: { only_integer: true }



  scope :mother, -> { where(sort: "mother") }
  scope :wish ,-> {where(sort: "wish")}
  scope :studying_now, -> {where(sort: "studying")}

  
end
