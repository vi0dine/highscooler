require 'rails_helper'

module Queries
  module Users
    RSpec.describe User, type: :request do
      describe '.resolve' do
        it 'returns a user data with given ID' do
          user = create(:user)
          user_id = user.id

          expect do
            post '/graphql', params: {
                query: query(id: user_id)
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :user)).to include(  id: be_present,
                                                          username: be_present,
                                                          email: be_present,
                                                          role: be_present,
                                                          gender: be_present,
                                                          city: be_present,
                                                          dateOfBirth: be_present,
                                                          dateOfMatura: be_present
                                                 )
            expect(result.dig(:data, :user, :id).count).to eq(user_id)
            expect(result.dig(:data, :user).count).to eq(1)
          end
        end

        def query(id:)
          <<-GRAPHQL
            query user(id: #{id}) {
              user {
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