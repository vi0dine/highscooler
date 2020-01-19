require 'rails_helper'

module Queries
  module Users
    RSpec.describe Users, type: :request do
      describe '.resolve' do
        it 'returns a users data' do
          create_list(:user, 10)

          expect do
            post '/graphql', params: {
                query: query
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :users)).to include( id: be_present,
                                                          username: be_present,
                                                          email: be_present,
                                                          role: be_present,
                                                          gender: be_present,
                                                          city: be_present,
                                                          dateOfBirth: be_present,
                                                          dateOfMatura: be_present
                                                          )
            expect(result.dig(:data, :users).count).to eq(10)
          end
        end

        def query()
          <<-GRAPHQL
            query users {
              users {
                id
                email
                username
                gender
                city
                role
                dateOfBirth
                dateOfMatura
              }
            }
          GRAPHQL
        end

      end
    end
  end
end