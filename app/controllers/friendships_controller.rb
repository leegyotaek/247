class FriendshipsController < ApplicationController
before_action :logged_in? , only: [:create, :destroy]
before_action :set_first , only: [:create, :destroy]




  def create
  current_user.ask_for_friends(@friend)
  respond_to  do |format|
  format.html {redirect_to :back, notice: "friend request sented"}
  format.json {render json: @friendship_for_me ,status: :created, location: @friendship_for_me}
  end
  end
  
  def destroy
  current_user.sayonara(@friend)
  respond_to do |format|
  format.html {redirect_to :back , notice: "friend was sucessfully destroyed"}
  format.json { head :no_content }
  end
  end

  




  private
  
  def set_first
  	@friend = User.find(params[:friend_id])
  end

  end
