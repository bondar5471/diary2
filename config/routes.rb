# frozen_string_literal: true

Rails.application.routes.draw do
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

  devise_for :user
  resources :days do
    member do
      get :file_uploads
    end
    resources :tasks
  end
  root to: 'days#index'
end
