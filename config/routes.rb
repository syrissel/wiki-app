Rails.application.routes.draw do

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
  # get 'search', to: 'pages#search'

  resources :categories

  resources :users
  resources :sessions
  resources :pages
  # get 'user_admin', to: 'pages#user_admin'


  # get 'new', to: 'pages#new'
  # patch 'pages/:id', to: 'pages#update', as: 'pages_update'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#index"

  

end
