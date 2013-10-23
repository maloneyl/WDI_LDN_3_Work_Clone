class UsersController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def list_admin
    @users = User.where(:role => "admin").all
    render :index
  end

  def edit
  end

  def update
    if removing_last_admin?
      flash.now[:alert] = "Can't change role of last admin!"
      render :edit
    elsif @user.update_attributes(params[:user])
      redirect_to users_url, notice: 'User was successfully updated!'
    else
      flash.now[:alert] = 'User was NOT updated!'
      render :edit
    end
  end

private

  def removing_last_admin?
    if @user.role?(:admin) && params[:user][:role] != "admin"
      User.where(:role => "admin").count == 1
    end
  end

end