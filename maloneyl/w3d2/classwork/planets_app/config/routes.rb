PlanetsApp::Application.routes.draw do

  # the 'to' refers to which controller and which method stuff should point at

  get    '/planets',          to: 'planets#index',  as: :planets
  post   '/planets',          to: 'planets#create'
  get    '/planets/new',      to: 'planets#new',    as: :new_planet
  get    '/planets/:id/edit', to: 'planets#edit',   as: :edit_planet
  get    '/planets/:id',      to: 'planets#show',   as: :planet
  put    '/planets/:id',      to: 'planets#update'  # update is different from edit; update refers to the form's action
  delete '/planets/:id',      to: 'planets#destroy'  

  # the :as bit makes planet_edit_url(@planet) and planet_edit_path(@planet) methods we can use in our views
  # _url is the full http://blahblahblah stuff, while _path is the relative link
  # edit is that page with that form

  root :to => 'planets#index' # so that if the user is at / instead of knowing to type /planets, it's still that page

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

end
