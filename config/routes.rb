# frozen_string_literal: true

Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  devise_for :users
  namespace :api, defaults: { format: :json } do
    resources :users, only: %i[create]
    resources :days do
      resources :tasks
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create, :destroy]
    end
  end    

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
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
  resources :days do
    member do
      get :file_uploads
    end
    resources :tasks
  end
  root to: 'days#index'
end
