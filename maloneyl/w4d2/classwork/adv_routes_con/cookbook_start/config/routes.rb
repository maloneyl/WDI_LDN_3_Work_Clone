R20130214Cookbook::Application.routes.draw do
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

  root to: "recipes#index"

  resources :users, only: [:index, :new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get "/signup", to: "users#new", as: "signup"
  get "/login", to: "sessions#new", as: "login"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # # DOING IT MANUALLY
  # put "/recipes/:id/flag", to: "recipes#flag", as: :flag_recipe
  # get "/recipes/flagged", to: "recipes#flagged", as: :flagged_recipes

end
