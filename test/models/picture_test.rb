require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:test)
  	@picture = @user.pictures.new(name:"pic1.png")
  end


  test "should be valid" do
  	assert @picture.valid?
  end

  test "name should be present" do
  	@picture.name = "   "
  	assert_not @picture.valid?


  end

  test "imageable_id should be present " do
  	@picture.imageable_id = "   "
  	assert_not @picture.valid?
  end

  test "imageable_type should be present" do
  	@picture.imageable_type = "   "
  	assert_not @picture.valid?

  end

  test "is_public's default value should be true" do

  assert @picture.is_public

  end

end
