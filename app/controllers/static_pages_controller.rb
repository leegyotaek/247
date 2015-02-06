class StaticPagesController < ApplicationController

  before_action :set_matcher 
  def home

  end


  def matching

    @req_matchers = current_user.req_matchers

    
  end


  private

  def set_matcher

  if logged_in?


  @matchers ||= current_user.matchings_for_today
  
  if @matchers.empty?
  flash.now[:danger] = "no matchings , set your matching option again"
  end
 
  end
    
  end
end
