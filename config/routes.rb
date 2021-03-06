Rails.application.routes.draw do

  resources :settings
  resources :pdfs
  resources :drafts, except: [:new]
  get 'draft/:id/new', to: 'drafts#new', as: 'new_draft'
  # get 'comments/create'
  # get 'comments/update'
  # get 'comments/destroy'
  resources :images
  # get 'categories/new'
  # # get 'categories/show'
  # get 'categories/create'
  # get 'categories/destroy'
  #get 'sessions/new'
  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'user/:id/destroy', to: 'users#destroy', as: 'destroy_user'
  delete 'pages/:id/destroy', to: 'pages#destroy', as: 'destroy_page'
  get 'review', to: 'pages#review'
  get 'categories/:id/move_up', to: 'categories#move_up', as: 'categories_move_up'
	get 'categories/:id/move_down', to: 'categories#move_down', as: 'categories_move_down'
  get 'categories/:id/destroy', to: 'categories#destroy', as: 'destroy_category'
	get 'admin', to: 'pages#admin'
	get 'review/wiki/:id', to: 'pages#review_wiki', as: 'review_wiki'
  patch 'executive/update/:id', to: 'pages#executive_update', as: 'executive_update'
	patch 'supervisor/update/:id', to: 'pages#supervisor_update', as: 'supervisor_update'
	patch 'admin/user/update/:id', to: 'users#admin_update', as: 'admin_update'
	patch 'user/update/:id', to: 'users#user_update', as: 'user_update'
	post 'pages/:id/edit', to: 'pages#update', as: 'edit_pages_path'
	# post 'videos/parse_html', to: 'videos#parse_html'
	# post 'videos/show/:id', to: 'videos#show'
  # get 'search', to: 'pages#search'
	get 'videos/upload', to: 'videos#base64_upload', as: 'base64'
	get 'password/:id', to: 'users#password', as: 'password_change'
	get 'bell-toggle', to: 'pages#bell_ring', as: 'bell_toggle'
	get 'refresh-forum/:id', to: 'page_forums#refresh_forum', as: 'refresh_forum'
  post 'create-forum', to: 'pages#create_page_forum', as: 'create_forum'
  patch 'change_password/:id', to: 'users#change_password'
  get 'wiki_management', to: 'pages#wiki_management'
  get 'unpublished', to: 'pages#unpublished', as: 'unpublished'
  get 'intern-registration', to: 'users#register_intern', as: 'register_intern'


  resources :categories
  resources :users
  resources :sessions
  resources :pages
  resources :videos
	resources :notifications
	resources :page_forums
  resources :comments
  resources :passwords
  resources :settings
  # resources :update_passwords
  get 'update-passwords/new/:id', to: 'update_passwords#new', as: 'new_update_passwords'
  post 'update-passwords/create/:id', to: 'update_passwords#create', as: 'create_update_passwords'
  # get 'user_admin', to: 'pages#user_admin'


  # get 'new', to: 'pages#new'
  # patch 'pages/:id', to: 'pages#update', as: 'pages_update'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#index"

  

end
