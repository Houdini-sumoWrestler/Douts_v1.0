Rails.application.routes.draw do
  get "users/new"
  get "users/create"
  root "pages#home"

  get "pages/home"

  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get  "/register", to: "users#new"
  post "/register", to: "users#create"

  get "up" => "rails/health#show", as: :rails_health_check
end