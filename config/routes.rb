Aregos::Application.routes.draw do

  root :to => 'products#index'  
  

  #resources
  resources :users
  resources :sessions , only: [:new, :create, :destroy]
  resources :products

  resources :carts , only: [:index, :show, :create, :destroy] do
    member do
      post 'add_to_cart'
      get 'checkout'      
    end
  end

  # faz post para o método "add_to_cart" e passa o id do produto como parâmetro
  post '/add_to_cart/:product_id' => 'carts#add_to_cart', :as => 'add_to_cart'

  resources :cart_items, only: [:destroy] do
    # "member" permite adicionar acções extra ao recurso (para além das default)
    member do
      put 'increase_quantity'
      put 'decrease_quantity'
    end
  end

  resources :orders

  resources :general_interactions, only: [:new, :create]
  
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  # static_pages
  match '/about_us',  to: 'static_pages#about_us'
  match '/caldas_de_aregos',  to: 'static_pages#caldas_de_aregos'

  # backoffice
  match '/admin',  to: 'admin/sessions#new'

  namespace :admin do    
    resources :sessions
    resources :products
    resources :orders
  end
 


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
