Rails.application.routes.draw do
  if Rails.env.test?
    require 'test_routes'
    define_test_routes
    namespace :cypress do
      resources :factories, only: %i[create]
      resources :sessions, only: %i[create]
    end
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  devise_for :users, skip: :sessions

  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
