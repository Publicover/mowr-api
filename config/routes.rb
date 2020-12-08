# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  namespace :api do
    namespace :v1 do
      resources :users, except: [:create]
      resources :addresses
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
