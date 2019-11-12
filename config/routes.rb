Rails.application.routes.draw do

  resources :pages

  get 'new', to: 'pages#new'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#index"

  post '/tinymce_assets' => 'tinymce_assets#create'

  

end
