Rails.application.routes.draw do
  root to: "static_pages#show"

  get "/users/new", to: "users#new"
  post "/users", to: "users#create"
  get "/profile", to: "users#show"
end
