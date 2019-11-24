Rails.application.routes.draw do

  #get 'sessions/new'
  get 'register', to: 'users#new', as: 'register'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'user/:id/destroy', to: 'users#destroy', as: 'destroy_user'
  delete 'pages/:id/destroy', to: 'pages#destroy', as: 'destroy_page'
  get 'review', to: 'pages#review'
  get 'categories', to: 'page_type#index'
  get 'categories/new', to: 'page_type#new'
  get 'categories/:id', to: 'page_type#show'
  

  # resources :page_type
  resources :users
  resources :sessions
  resources :pages, only: [:index, :show, :new, :create, :edit, :update]
  # get 'user_admin', to: 'pages#user_admin'


  # get 'new', to: 'pages#new'
  # patch 'pages/:id', to: 'pages#update', as: 'pages_update'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#index"

  post '/tinymce_assets' => 'tinymce_assets#create'

  

end
