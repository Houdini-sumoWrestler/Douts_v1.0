Rails.application.routes.draw do
  get "events/index"
  get "events/show"
  get "events/new"
  get "events/create"
  get "user_dashboard/show"
  get "member_dashboard/show"
  get "admin/dashboard"
  get "users/new"
  get "users/create"
  root "pages#home"

  get "pages/home"

  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "user_dashboard#show"

  get  "/register", to: "users#new"
  post "/register", to: "users#create"

  resources :events, only: [:index, :show, :new, :create]

  get "/admin", to: "admin#dashboard"

  get "up" => "rails/health#show", as: :rails_health_check
end