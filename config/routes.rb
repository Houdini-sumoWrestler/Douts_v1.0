Rails.application.routes.draw do
  get "event_assets/create"
  get "event_assets/destroy"

  get "event_registrations/create"
  get "event_registrations/destroy"
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

  resources :events, only: [:index, :show, :new, :create] do
    resources :event_registrations, only: [:create]
  end

  resources :event_registrations, only: [:destroy]

  resources :assets, path: "asset-register", only: [:index, :show, :new, :create]

  resources :events, only: [:index, :show, :new, :create] do
    resources :event_assets, only: [:create]
  end

  resources :pages do
    resources :page_sections, except: [:index, :show]
  end

  resources :nav_items do
    collection do
      get :edit_menu
    end

    member do
      patch :move_up
      patch :move_down
    end
  end

  resources :event_assets, only: [:destroy]

  get "/admin", to: "admin#dashboard"

  get "up" => "rails/health#show", as: :rails_health_check
end