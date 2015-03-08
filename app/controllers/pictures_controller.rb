class PicturesController < ApplicationController
  def update
  	@picture = Picture.find(params[:id])

  	if @picture.update_attributes(pictures_params)
  		redirect_to :back
      

  	else
  		redirect_to root_path

  	end

  end



  def pictures_params

	params.require(:picture).permit(:name, :imageable_id, :imageable_type, :is_public)
	
  end



end
