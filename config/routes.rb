# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :plows
        resources :services
        resources :users, except: [:create]
        resources :addresses
        resources :size_estimates
        resources :service_requests
        resources :early_birds
        resources :service_deliveries
        resources :snow_accumulations
        resources :daily_routes
      end
      namespace :driver do
        resources :plows
        resources :services, only: %i[index show]
        resources :users, except: [:create]
        resources :addresses
        resources :service_requests, only: [:show]
        resources :early_birds, only: %i[index show]
        resources :daily_routes, only: [:show]
      end
      namespace :customer do
        resources :plows
        resources :services
        resources :users, except: [:create]
        resources :addresses
        resources :size_estimates
        resources :service_requests
        resources :early_birds
      end
    end
  end
end
