Aregos::Application.routes.draw do

  root :to => 'products#index'  
  

  #resources
  resources :users do
    member do
      # a action "recover_password" serve para gerar o form em que o utilizador indica o endereço de e-mail
      get 'recover_password'
      # a action "send_password_recover_email" é a ação invocada no form da acção "recover_password"
      # => é a acção que trata efectivamente do envio do e-mail
      post 'send_password_recover_email'
      get 'edit_password'
      put 'update_password'
    end
  end
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

  # recuperação da password
  match '/recover_password',  to: 'users#recover_password'
  match '/send_password_recover_email',  to: 'users#send_password_recover_email'
  match '/edit_password',  to: 'users#edit_password'
  match '/update_password',  to: 'users#update_password'  

  # static_pages
  match '/about_us',  to: 'static_pages#about_us'
  match '/caldas_de_aregos',  to: 'static_pages#caldas_de_aregos'

  # backoffice
  match '/admin',  to: 'admin/sessions#new'

  namespace :admin do    
    resources :sessions
    resources :products
    resources :orders do
      # "member" permite adicionar acções extra ao recurso (para além das default)
      member do
        post 'add_order_action'
      end
    end
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
