# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'homepage#index'

  scope :users do
    get '/:id', to: 'users/dashboard#show', as: :dashboard
  end

  scope :highschools do
    get '/new', to: 'high_schools#new', as: :new_highschool
    post '/new', to: 'high_schools#create', as: :create_highschool
  end

  scope :academies do
    get '/', to: 'academies#index', as: :academies
    get '/new', to: 'academies#new', as: :new_academy
    post '/new', to: 'academies#create', as: :create_academy
    get '/:id', to: 'academies#show', as: :academy
    post '/new_opinion', to: 'academies#create_academy_opinion', as: :create_academy_opinion
  end

  scope :fields do
    get '/', to: 'fields#index', as: :fields
    get '/new_field', to: 'fields#new_field', as: :new_field
    post '/new_field', to: 'fields#create_field', as: :create_field
    get '/new_detail', to: 'fields#new_detail', as: :new_detail
    post '/new_detail', to: 'fields#create_detail', as: :create_detail
    get '/:id', to: 'fields#show', as: :field
  end
end
