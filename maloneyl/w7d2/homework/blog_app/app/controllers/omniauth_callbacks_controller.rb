class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # method name should match strategy name (i.e. google_oauth2 in our case)
  # reminder: our redirect uri is: http://localhost:3000/users/auth/google_oauth2/callback
  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"]) # our own method
    if user.persisted? # a rails method: checks if the user is in the database (if there's an id)
      flash.notice = "Signed in through Google!"
      sign_in_and_redirect user # this is a devise method
    else
      session["devise.user_attributes"] = user.attributes # user.attributes returns a hash of that user object from google; we're stashing this info in our session
      flash.notice = "Problem creating account"
      redirect_to new_user_registration_url
    end
  end

end

