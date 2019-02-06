# frozen_string_literal: true

Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :days do
        resources :tasks
      end
    end
  end
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
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
