# frozen_string_literal: true

Rails.application.routes.draw do
  resources :cards
  resources :lists
  root to: 'days#index'

  devise_for :user
  resources :notices, only: %i[new create destroy]
  resources :days do
    resources :tasks, only: %i[new create destroy]
  end
end
