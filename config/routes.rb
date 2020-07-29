Rails.application.routes.draw do
  root to: 'static_pages#show'

  get '/users/new', to: 'users#new'
  post '/users', to: 'users#create'
  get '/profile', to: 'users#show'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    get '/game_sessions/new', to: 'game_sessions#new'
    post '/game_sessions', to: 'game_sessions#create'
  end

  get '/passwordless-login', to: 'sessions#passwordless_new', as: :passwordless_login
  post '/passwordless-login', to: 'sessions#passwordless_create', as: :passwordless_login_post
  get '/auth/:login_uuid', to: 'sessions#passwordless_return', as: :passwordless_return

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :monsters, only: [:index, :show]

  resources :characters, only: [:index]

  resources :game_sessions, only: [:show] do
    resources :adventure_logs, only: [:new, :create]
  end

end
