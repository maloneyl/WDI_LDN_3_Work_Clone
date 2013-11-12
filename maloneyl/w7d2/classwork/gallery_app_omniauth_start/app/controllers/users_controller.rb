class UsersController < Devise::RegistrationsController

  def index
    @users = User.all
  end

  def create
    # run the default version in Devise::RegistrationsController
    super
    # then run our custom logic
    @user.role = 'foo'
    @user.save!
  end

  def edit
    logger.info self.class.ancestors
    super
  end

end