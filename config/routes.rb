# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    post 'user_token' => 'user_token#create'
    resources :lists do
      member do
        patch :move
      end
    end
    resources :cards do
      member do
        patch :move
      end
    end
    resources :users, only: %i[create destroy]
    resources :days do
      resources :tasks
    end
    resources :tasks do
      post 'multi_create', on: :collection
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sessions, only: %i[create destroy]
    end
  end
  root to: 'days#index'
end
