# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  namespace :api do
    namespace :v1 do
      resources :plows
      resources :services
      resources :users, except: [:create]
      resources :addresses
      resources :size_estimates
      resources :service_requests
    end
  end
end
