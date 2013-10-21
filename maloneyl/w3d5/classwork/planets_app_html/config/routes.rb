PlanetsApp::Application.routes.draw do

  # get    '/planets',          to: 'planets#index',  as: :planets
  # post   '/planets',          to: 'planets#create'
  # get    '/planets/new',      to: 'planets#new',    as: :new_planet
  # get    '/planets/:id/edit', to: 'planets#edit',   as: :edit_planet # edit_planet_path(@planet)
  # get    '/planets/:id',      to: 'planets#show',   as: :planet
  # put    '/planets/:id',      to: 'planets#update'
  # delete '/planets/:id',      to: 'planets#destroy'

  resources :planets

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  root :to => 'planets#index'

end
