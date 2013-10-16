MoonsApp::Application.routes.draw do

  get    '/moons',          to: 'moons#index',  as: :moons
  post   '/moons',          to: 'moons#create'
  get    '/moons/new',      to: 'moons#new',    as: :new_moon
  get    '/moons/:id/edit', to: 'moons#edit',   as: :edit_moon
  get    '/moons/:id',      to: 'moons#show',   as: :moon
  put    '/moons/:id',      to: 'moons#update'  # update is different from edit; update refers to the form's action
  delete '/moons/:id',      to: 'moons#destroy'  

  root :to => 'moons#index'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

end
