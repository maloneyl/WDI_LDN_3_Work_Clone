class UsersController < Devise::RegistrationsController # yes, inheriting from the Devise good stuff

  def index
    @users = User.all
  end

  def create
    # run the default version in Devise::RegistrationsController
    super # this means use the method with the same name from the super (parent) class

    # then run our custom logic
    @user.role = "user"
    @user.save!
  end

  def edit
    # run the default version in Devise::RegistrationsController
    logger.info self.class.ancestors
    super
  end

end
