Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :brands
      resources :product_lines
      resources :models
      resources :shops
      resources :items
    end
  end
end
