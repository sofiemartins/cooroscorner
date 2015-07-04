Rails.application.routes.draw do

  root :to => 'welcome#index'

  get '/404', :to => 'errors#not_found'
  get '/500', :to => 'errors#internal_server_error'

  devise_for :user, :controllers => {
    :sessions => 'user/sessions', 
    :registrations => 'user/registrations'
  }

  devise_scope :user do
    get "login", 			:to => "user/sessions#new" 
    post "login", 			:to => "user/sessions#create"
    get "logout", 			:to => "user/sessions#destroy"
    get '/list/users', 			:to => "user/registrations#list"
  end

  # Admin routes
  get 'help'					=> 'documentation#help'
  get 'upload'					=> 'comic#new'
  post 'upload'					=> 'comic#create'
  get '/list/comics'				=> 'comic#list'
  get '/edit/comic/:category/:index'		=> 'comic#edit'
  post '/edit/comic/:category/:index'		=> 'comic#submit_edit'
  get '/delete/comic/:category/:index'		=> 'comic#destroy'
  get 'category'				=> 'category#new'
  post 'category'				=> 'category#create'
  get '/list/categories'			=> 'category#list'
  get '/edit/category/:short'			=> 'category#edit'
  post '/edit/category/:short'			=> 'category#submit_edit'
  get '/delete/category/:short'			=> 'category#destroy'
  get 'background'				=> 'background#new'
  post 'background'				=> 'background#create'
  get '/list/backgrounds'			=> 'background#list'
  get '/edit/background/:label'			=> 'background#edit'
  post "/edit/background/:label"		=> 'background#submit_edit'
  get '/delete/background/:label'		=> 'background#destroy'
 
  # only accessible for users	
  post '/comment/:category/:index' 	=> 'comic#comment'

  # Static pages, accessible for everyone
  get 'about'				=> 'welcome#about'
  get '/archive/:index'			=> 'comic#archive'
  get 'archive'				=> 'comic#archive_last'

  get '/back/:category/:index'		=> 'comic#back'
  get '/next/:category/:index'		=> 'comic#next'
  get '/random/:category/:index' 	=> 'comic#random'

  get '/:category/:index'		=> 'comic#show'
  get '/:category'			=> 'comic#show_last'
end
