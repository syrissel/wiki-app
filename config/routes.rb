Rails.application.routes.draw do

  resources :pages, only: [:index, :show, :new, :create, :edit, :update]


  # get 'new', to: 'pages#new'
  # patch 'pages/:id', to: 'pages#update', as: 'pages_update'


  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#index"

  post '/tinymce_assets' => 'tinymce_assets#create'

  

end
