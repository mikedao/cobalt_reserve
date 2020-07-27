Rails.application.routes.draw do
  root to: "static_pages#show"

  get "/users/new", to: "users#new"
  post "/users", to: "users#create"
  get "/profile", to: "users#show"

  get '/passwordless-login', to: 'sessions#passwordless_login', as: :passwordless_login
  post '/passwordless-login', to: 'sessions#passwordless_create', as: :passwordless_login_post
  get '/auth/:character_uuid', to: 'sessions#passwordless_return', as: :passwordless_return

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
