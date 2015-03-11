class MeetingsController < ApplicationController
  def index
  	@meetings = Meeting.all
  @my_meetings = current_user.meetings
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


  def show
    @meeting = Meeting.find(params[:id])


  end


  def join

    @meeting = Meeting.find(params[:meeting_id])
    @meeting.groups.build(member_id: current_user.id).save

    flash[:info] = "successfully joined"
    redirect_to @meeting

  end

    def disjoin

    @meeting = Meeting.find(params[:meeting_id])
    
    @group = @meeting.groups.where(member_id: current_user.id)
    Group.destroy @group  


    flash[:info] = "successfully disjoined"
    redirect_to @meeting || :back

  end





  private

  def meeting_params

  	params.require(:meeting).permit(:intro_img, :name, :member_id, :introduce)
  	
  end

end
