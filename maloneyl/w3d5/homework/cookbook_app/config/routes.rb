CookbookApp::Application.routes.draw do

  # resources :recipes, :ingredients

  get    '/recipes',          to: 'recipes#index',  as: :recipes
  post   '/recipes',          to: 'recipes#create'
  get    '/recipes/new',      to: 'recipes#new',    as: :new_recipe
  get    '/recipes/:id/edit', to: 'recipes#edit',   as: :edit_recipe
  get    '/recipes/:id',      to: 'recipes#show',   as: :recipe
  put    '/recipes/:id',      to: 'recipes#update'
  delete '/recipes/:id',      to: 'recipes#destroy'

  get    '/ingredients',          to: 'ingredients#index',  as: :ingredients
  post   '/ingredients',          to: 'ingredients#create'
  get    '/ingredients/new',      to: 'ingredients#new',    as: :new_ingredient
  get    '/ingredients/:id/edit', to: 'ingredients#edit',   as: :edit_ingredient
  get    '/ingredients/:id',      to: 'ingredients#show',   as: :ingredient
  put    '/ingredients/:id',      to: 'ingredients#update'
  delete '/ingredients/:id',      to: 'ingredients#destroy'

  root :to => 'recipes#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
