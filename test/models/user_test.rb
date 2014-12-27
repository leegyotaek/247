require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "Example User", email: "user@example.com",
                       password: "foobar", password_confirmation: "foobar")
  end

  test "sholud be vaild" do

  	assert @user.valid?
  end

  test "name must be present" do
	@user.name = "  "
  
	assert_not @user.valid?
  end

  test "email must be present" do
  @user.email = "  "
  
  assert_not @user.valid?
  end

  test "name must not too long" do
  @user.name = "a" *  51
  assert_not @user.valid?
  end

    test "email must not too long" do
  @user.email = "a" * 256
  assert_not @user.valid?
  end

  test "email validation check with invalid_address" do

 invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be saved as lower-case" do

  mixed_case_email = "Foo@ExamPle.Com"
  @user.email = mixed_case_email
  @user.save
  assert_equal mixed_case_email.downcase, @user.reload.email
  end


  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
  @user.password = @user.password_confirmation = "a" * 5
  assert_not @user.valid?
  end


end
