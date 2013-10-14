MyFirstRailsApp::Application.routes.draw do

  resources :posts do
    resources :comments, :only => :create
  end

end
