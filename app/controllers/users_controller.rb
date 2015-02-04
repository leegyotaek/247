class UsersController < ApplicationController
  before_action :set_user , only: [:show , :edit , :update, :edstroy, :following, :followers, 
    :correct_user, :update_profile, :friends]
  before_action :logged_in_user, only: [ :index, :edit,:update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  layout 'scaffold_layout', :only => [:show,:edit]
  def new
  @user = User.new
  end

  def show
  render 'update_profile' if current_user.newbie 
  @microposts = @user.microposts.paginate(page: params[:page])
  redirect_to root_url and return unless @user.activated?
  end

  def create
  @user = User.new(user_params)

  if @user.save
   @user.send_activation_email
   flash[:info] = "Please check your email to activate your account."
   redirect_to root_url
  

  else
	render 'new'
  end
end

def edit

end


def update

  if @user.update_attributes(user_params)
     @user.update_attributes(newbie: false)
    flash[:success] = "업데이트 완료"
    redirect_to @user
  else
    render 'edit'
  end
end

def update_profile


end


def destroy
  User.find(params[:id]).destroy
  flash[:success] = "삭제 되었습니다."
  redirect_to users_url
end


def index
  @users = User.where(activated: true).paginate(page: params[:page])
end 


def following
  @title = "following"
  @users = @user.following.paginate(page: params[:page])
  render 'show_follow'
end

def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
end

def accept #친구수락
    @friend = User.find(params[:id])
    current_user.accept_friend_request(@friend)
    respond_to do |format|
      format.html {redirect_to :back, notice: "become friends"}
   end 
end

def friends
  @users = @user.friends.paginate(page: params[:page])
  render 'show_friends'
  @requesters = @user.request_friends
end
      


private


  def set_user

    @user = User.find(params[:id])


  end
  
  def user_params
  	params.require(:user).permit(:name,:email, :birthday, :password, :password_confirmation, :introduce, 
      :interests, :status, :gender, :country, :region, :city, :matching_lan, :matching_age_to, :matching_age_from, :matching_interest,  pictures_attributes: [:id, :name, :imageable_id, :imageable_type, :is_public, :_destroy] , 
      languages_attributes: [:id, :language , :level , :user_id , :sort, :_destroy], 
      wish_languages_attributes: [:id, :language , :level , :user_id , :sort, :_destroy])
  end

 

 
 def correct_user
   @user = User.find(params[:id])
   redirect_to(root_url) unless current_user?(@user)

 end

 def admin_user

  redirect_to root_url unless current_user.admin?


 end


  end
