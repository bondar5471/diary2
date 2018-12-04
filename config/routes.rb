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
  resources :days do
    resources :tasks
  end
  root to: 'days#index'
end
