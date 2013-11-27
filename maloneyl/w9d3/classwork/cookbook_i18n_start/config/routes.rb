R20130214Cookbook::Application.routes.draw do

  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout'}, :controllers => {:registrations => 'users'}

  devise_scope :user do
    resources :users, only: [:index, :edit] do
      collection do
        get :list_admin
      end
    end
  end

  resources :ingredients

  resources :recipes do
    member do
      put :flag
    end
    collection do
      get :flagged
    end
    resources :quantities, only: [:new, :destroy, :create]
  end

  root to:  "recipes#index"

  # get "/signup",    to: "users#new",         as: "signup"
  # get "/login",     to: "sessions#new" ,     as: "login"
  # delete "/logout", to: "sessions#destroy",  as: "logout"

end
