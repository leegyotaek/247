class StaticPagesController < ApplicationController
  def home
  if logged_in?

  @matchers ||= current_user.matchings_for_today

  if @matchers.empty?

  flash.now[:danger] = "no matchings , set your matching option agai"

  end
 
  end
  end
end
