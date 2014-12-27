class UsersController < ApplicationController
  def new
  @user = User.new
  end

  def show
  @user = User.find(params[:id])
  end

  def create
  @user = User.new(user_params)

  if @user.save
  	flash[:success] = "회원가입이 완료되었습니다"
  	redirect_to @user

  else
	render 'new'
  end
end


  def user_params
  	params.require(:user).permit(:name,:email,:password, :password_confirmation)
  end

end
