class UsersController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def new
    # @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User info was successfully updated!'
    else
      flash[:alert] = 'User info was NOT updated!'
      render :edit
    end
  end  

  def list_admins
    @users = User.where(role: "admin").all
    render :index
  end

  def edit_role
    @users = User.all
  end

  def update_role
    @user = User.where(id: params[:user_id].to_i)
    @user.role = params[:role]
    @user.save
    redirect_to users_path
  end

end
