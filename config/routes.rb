# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'homepage#index'

  scope :users do
    get '/:id', to: 'users/dashboard#show', as: :dashboard
  end

  scope :academies do
    get '/', to: 'academies#index', as: :academies
    get '/new', to: 'academies#new', as: :new_academy
    post '/new', to: 'academies#create', as: :create_academy
    get '/:id', to: 'academies#show', as: :academy
  end

  scope :fields do
    get '/', to: 'fields#index', as: :fields
    get '/new_field', to: 'fields#new_field', as: :new_field
    post '/new_field', to: 'fields#create_field', as: :create_field
    get '/new_details', to: 'fields#new_details', as: :new_details
    post '/new_details', to: 'fields#create_details', as: :create_details
    get '/:id', to: 'fields#show', as: :field
  end
end
