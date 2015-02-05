class StaticPagesController < ApplicationController
  def home
  if logged_in?


  @matchers ||= current_user.matchings_for_today
  
  if @matchers.empty?
  flash.now[:danger] = "no matchings , set your matching option again"
  end
 
  end
  end
end
