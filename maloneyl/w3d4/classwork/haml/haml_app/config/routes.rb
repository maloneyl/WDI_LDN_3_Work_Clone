HamlApp::Application.routes.draw do

  # match: get, post, etc. to be handled by the index action/method of the home controller
  match '/' => 'home#index'

end
