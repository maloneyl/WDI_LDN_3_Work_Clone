R20130214Cookbook::Application.routes.draw do

  resources :ingredients

  resources :users, except: [:destroy] do
    collection do
      get :list_admin
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  resources :recipes do
    member do
      put :flag
    end
    collection do
      get :flagged
    end
    resources :quantities, only: [:new, :destroy, :create] do 
      member do 
        put 'move/:direction', to: 'quantities#move_in_list', as: 'move_in_list'
      end
    end
  end

  root to:  "recipes#index"

  get "/signup", to: "users#new",         as: "signup"
  get "/login",  to: "sessions#new" ,     as: "login"
  delete "/logout", to: "sessions#destroy",  as: "logout"

end
