module SessionsHelper



def log_in(user)
 session[:user_id] = user.id
end



def current_user
	if(user_id = session[:user_id])
	@current_user ||= User.find_by(id: user_id)#find로 찾을경우 current_user가 없으면 에러 발생 find_by는 nill 리턴
	elsif(user_id = cookies.signed[:user_id])
	user=User.find_by(id: user_id)
	if user && user.authenticated?(:remember, cookies[:remember_token])
	 log_in user
	 @current_user = user
	 end
	end
	
end


def logged_in?
	!current_user.nil?
end



def first_logged_in_today?
current_user.first_login_today?
end


def forget(user)
	user.forget
end

def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
end

def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
	# cookies[:remember_token] = { value:   remember_token,
 	#                           expires: 20.years.from_now.utc }
	

end


def current_user?(user)

	user == current_user
	
end

# Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end


end
