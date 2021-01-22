# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute" if Rails.env.development?
  post "/graphql", to: "graphql#execute"
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  namespace :stripe do
    mount StripeEvent::Engine, at: '/webhooks'
  end
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
        resources :base_locations
        resources :complete_daily_routes, only: [:update]
        resources :payment_methods
        resources :payments
      end
      namespace :driver do
        resources :plows
        resources :services, only: %i[index show]
        resources :users, except: [:create]
        resources :addresses
        resources :service_requests, only: [:show]
        resources :early_birds, only: %i[index show]
        resources :daily_routes, only: [:show]
        resources :base_locations, only: %i[index show]
      end
      namespace :customer do
        resources :plows
        resources :services
        resources :users, except: [:create]
        resources :addresses
        resources :size_estimates
        resources :service_requests
        resources :early_birds
        resources :payment_methods
        resources :payments, only: %i[index show]
      end
    end
  end
end
