# frozen_string_literal: true

Rails.application.routes.draw do
  # Routes for Google authentication
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
  mount ActionCable.server => '/cable'
  resources :chats
end
