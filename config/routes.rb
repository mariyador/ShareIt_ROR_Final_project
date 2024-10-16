Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Custom routes
  get "home/index"
  get "about" => "pages#about"
  get "contacts" => "pages#contacts"

  # Define the root path route ("/")
  root to: "home#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Resources
  resources :items do
    collection do
      get "my_items", to: "items#my_items"
      get "reserved_items", to: "items#reserved_items"
    end
    member do
      post "reserve"
      delete :unreserve
    end
  end

  resources :users
end
