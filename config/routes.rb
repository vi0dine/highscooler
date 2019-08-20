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
    get '/:id', to: 'academies#show', as: :academy
  end

  scope :fields do
    get '/', to: 'fields#index', as: :fields
    get '/new', to: 'fields#new', as: :new_field
    get '/:id', to: 'fields#show', as: :field
  end
end
