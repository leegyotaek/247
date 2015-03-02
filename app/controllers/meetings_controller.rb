class MeetingsController < ApplicationController
  def index
  	@meetings = Meeting.all
  end


  def new
  	@meeting = Meeting.new
  end


  def create
  	@meeting = current_user.meetings.new(meeting_params)
  	if @meeting.save
  		flash[:info] = "successfully crated"
  		redirect_to meetings_path
  	else
  		render 'new'
  	end
  end



  private

  def meeting_params

  	params.require(:meeting).permit(:intro_img, :name, :user_id, :introduce)
  	
  end

end
