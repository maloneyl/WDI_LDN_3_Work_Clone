class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # i.e. if we already have a value in current_user, we don't do the "User.find…." bit (i.e. not wasting db query)
  end

  def logged_in?
    !!current_user
    # current_user returns either nil or user object
    # !current_user will then return either (!nil) or false
    # !! gives you inverse of value IN BOOLEAN
    # try in irb if confused
  end

  def authenticate
    # redirect to login if user not signed in
  end

end
