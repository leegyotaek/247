class Language < ActiveRecord::Base
  belongs_to :user
  validates :level , numericality: { only_integer: true }
end
