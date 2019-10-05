# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root 'homepage#index'

  scope :users do
    get '/:id', to: 'users/dashboard#show', as: :dashboard
    post '/:id/interested', to: 'interested#create', as: :create_interest
    post '/:id/study_interest', to: 'users/study_interests#create', as: :create_study_interest
    delete '/:id/study_interest', to: 'users/study_interests#delete', as: :delete_study_interest
    post '/:id/matura_results', to: 'users/matura_results#create', as: :add_matura_result
    put '/:id/matura_results', to: 'users/matura_results#update', as: :edit_matura_result
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
    post '/new_opinion', to: 'academy_opinions#create', as: :create_academy_opinion
  end

  scope :fields do
    get '/', to: 'fields#index', as: :fields
    get '/new_field', to: 'fields#new', as: :new_field
    post '/new_field', to: 'fields#create', as: :create_field
    get '/new_detail', to: 'field_details#new', as: :new_detail
    post '/new_detail', to: 'field_details#create', as: :create_detail
    get '/:id', to: 'fields#show', as: :field
    post '/new_opinion', to: 'field_opinions#create', as: :create_field_opinion
  end
end
