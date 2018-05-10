# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  # APIs
  mount Chat::Base, at: '/'

  # Users
  resources :users
end
