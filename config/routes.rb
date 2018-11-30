# frozen_string_literal: true

Rails.application.routes.draw do
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
  resources :notices, only: %i[new create destroy]
  resources :days do
    resources :tasks
    member do
      delete :destroy_on_month
    end
  end
  root to: 'days#index'
end
