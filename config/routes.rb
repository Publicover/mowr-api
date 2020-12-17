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
      end
      namespace :driver do
        resources :plows
        resources :services, only: [:index, :show]
        resources :users, except: [:create]
        resources :addresses
        resources :size_estimates
        resources :service_requests, only: [:show]
        resources :early_birds, only: [:index, :show]
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
