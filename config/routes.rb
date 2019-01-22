# frozen_string_literal: true

Rails.application.routes.draw do
  get 'chats/index'
  get 'chats/new'
  get 'chats/create'
  get 'chats/show'
  get 'chatrooms/index'
  get 'chatrooms/new'
  get 'chatrooms/create'
  get 'chatrooms/show'
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
  resources :chatrooms
    resources :chats
    get '/dashboard', to: 'chats#index'
  root to: 'days#index'
end
