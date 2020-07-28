Rails.application.routes.draw do
  root to: 'static_pages#show'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
  end

  get '/passwordless-login', to: 'sessions#passwordless_new', as: :passwordless_login
  post '/passwordless-login', to: 'sessions#passwordless_create', as: :passwordless_login_post
  get '/auth/:login_uuid', to: 'sessions#passwordless_return', as: :passwordless_return

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :monsters, only: [:index, :show]
  resources :characters, only: [:index]

  get '/profile', to: 'users#show'
  resources :users, only: [:new, :create] do
    resources :characters, only: [:new, :create]
  end
end
