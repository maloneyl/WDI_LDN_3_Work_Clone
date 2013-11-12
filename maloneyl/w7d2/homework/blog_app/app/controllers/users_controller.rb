class UsersController < Devise::RegistrationsController # inherits from Devise's original

  # def index
  #   @users = User.all
  # end

  def create
    # run the default version in Devise::RegistrationsController
    super # this means use the method with the same name from the super (parent) class

    # then run our custom logic
    # @user.name = params[:user]["name"] # :O don't need to do this! the name field is on the field, which just gets saved as a big hash
    @user.role = "contributor"
    @user.save!
  end

  # def edit
  #   # run the default version in Devise::RegistrationsController
  #   super

  #   # then run our custom logic
  #   # role cannot be changed
  # end

end
