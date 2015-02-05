class StaticPagesController < ApplicationController
  def home
  if logged_in?

  	# if first_logged_in_today?
  	# @matchers = current_user.search_for_matcher
  	# end

  @matchers ||= current_user.matchings_for_today
  
  if @matchers.empty?
  flash.now[:danger] = "no matchings , set your matching option again"
  end
 
  end
  end
end
