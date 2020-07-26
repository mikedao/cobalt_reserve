Rails.application.routes.draw do
  root to: "static_pages#show"

  get "/users/new", to: "users#new"
  post "/users", to: "users#create"
  get "/profile", to: "users#show"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :monsters, only: [:index]
end
