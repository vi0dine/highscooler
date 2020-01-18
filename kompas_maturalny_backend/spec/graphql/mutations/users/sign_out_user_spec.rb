require 'rails_helper'

module Mutations
  module Users
    RSpec.describe SignOutUser, type: :request do
      describe '.resolve' do
        it "signs out the current user" do
          user = create(:user)
          auth_token = user.authentication_token

          expect do
            post '/graphql', params: {
                query: query
            }, headers: { Authentication: "Bearer: #{auth_token}" }

            result = response.body.to_h.deep_symbolize_keys

            user.reload
            expect(result.dig(:user, :id)).to eq(user.gql_id)
            expect(result.dig(:user, :authenticationToken)).to_not eq(auth_token)
            expect(user.authentication_token).to_not eq(auth_token)
          end
        end

        it "raises error for user not signed in" do
          expect do
            post '/graphql', params: {
                query: query
            }, headers: { Authentication: "Bearer: #{auth_token}" }

            result = response.body.to_h.deep_symbolize_keys

            expect(result.dig(:errors, 0, :message)).to eq("User not signed in")
            expect(result.dig(:data, :signIn)).to be_blank
          end
        end
      end

        def query()
          <<-GRAPHQL
            mutation {
              signOutUser(input: {}) {
                user {
                  id
                  email
                  username
                  role
                  authenticationToken
                }
              }
            }
          GRAPHQL
        end
      end
    end
  end