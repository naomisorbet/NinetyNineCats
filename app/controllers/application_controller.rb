class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_user!
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def log_in(user)
    user.give_session_token
    user.save!
    session[:session_token] = user.session_token
  end
end
