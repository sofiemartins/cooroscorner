Rails.application.routes.draw do

  devise_for :user, :controllers => {
    :sessions => 'user/sessions', 
    :registrations => 'user/registrations'
  }

  devise_scope :user do
    get "login", :to => "user/sessions#new" 
    post "login", :to => "user/sessions#create"
    get "register", :to	=> "user/registrations#new"
    post "register", :to => "user/registrations#create"
    get "preferences", :to => "user/registrations#edit"
    get "logout", :to => "user/sessions#destroy"
  end

  # Admin routes
  get 'upload'			=> 'comic#new'
  post 'upload'			=> 'comic#create'

  # Static pages, accessible for everyone
  get 'offensive'		=> 'comic#offensive'
  get 'random'			=> 'comic#random'
  get 'mayuyu'			=> 'comic#mayuyu'
  get 'tina'			=> 'comic#tina'
  get 'archive'			=> 'comic#archive'
  get 'about'			=> 'welcome#about'

  # accessing comics
  get '/archive/:index'		=> 'comic#archive'
  get '/offensive/:index'	=> 'comic#offensive'
  get '/random/:index'		=> 'comic#random'
  get '/mayuyu/:index'		=> 'comic#mayuyu'
  get '/tina/:index'		=> 'comic#tina'

  root :to => 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
