MoviesActorsApp::Application.routes.draw do

  get    '/movies',          to: 'movies#index',  as: :movies
  post   '/movies',          to: 'movies#create'
  get    '/movies/new',      to: 'movies#new',    as: :new_movie
  get    '/movies/:id/edit', to: 'movies#edit',   as: :edit_movie
  get    '/movies/:id',      to: 'movies#show',   as: :movie
  put    '/movies/:id',      to: 'movies#update'
  delete '/movies/:id',      to: 'movies#destroy'

  get    '/actors',          to: 'actors#index',  as: :actors
  post   '/actors',          to: 'actors#create'
  get    '/actors/new',      to: 'actors#new',    as: :new_actor
  get    '/actors/:id/edit', to: 'actors#edit',   as: :edit_actor
  get    '/actors/:id',      to: 'actors#show',   as: :actor
  put    '/actors/:id',      to: 'actors#update'
  delete '/actors/:id',      to: 'actors#destroy'

  root :to => 'movies#index'

end
