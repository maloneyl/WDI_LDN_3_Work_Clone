class ApplicationController < ActionController::Base
  protect_from_forgery

  # we need to create JSON to work with Devise

  respond_to :json
  helper_method :current_user_json
  serialization_scope :current_user
  before_filter :update_sanitized_params, if: :devise_controller?

  def current_user_json
    if current_user
      UserSerializer.new(current_user, :scope => current_user, :root => false).to_json # root refers to the parent model name (pluralized) preceding the array of records, e.g. 'posts' when we visit http://localhost:3000/posts.json
    else
      {}.to_json
    end
  end

  # this is needed because API can come with a lot more fields than what's required for Devise
  # this method sliced out only those relevant for Devise
  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.slice(:name, :email, :password, :password_confirmation)}
  end

end
