# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'homepage#index'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
end
