class SessionsController < ApplicationController

  def new # form -> views/sessions/new.haml.html
  end

  def create # the actual sign-in
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password]) # if there is a user associated with the email given and the password is right
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid login credentials"
      render :new
    end
  end

  def destroy # logout
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
