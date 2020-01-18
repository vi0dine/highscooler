require 'rails_helper'

module Mutations
  module Users
    RSpec.describe SignInUser, type: :request do
      describe '.resolve' do
        it 'returns a user data' do
          user = build(:user)

          expect do
            post '/graphql', params: {
                query: query(
                    email: user.email,
                    password: user.password
                )
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :signInUser)).to include(id: be_present,
                                                              username: user.username,
                                                              email: user.email,
                                                              role: 'schoolboy',
                                                              authenticationToken: be_present)
          end
        end

        it "raises error for incorrect email/password" do
          user = create(:user, email: 'valid@valid.com', password: "12345678")

          expect do
            post '/graphql', params: {
                query: query(
                    email: user.email,
                    password: "87654321"
                )
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys

            expect(result.dig(:errors, 0, :message)).to eq("Incorrect Email/Password")
            expect(result.dig(:data, :signInUser)).to be_blank
          end
        end

        it "raises error for missing user" do
          user = create(:user, email: 'valid@valid.com', password: "12345678")

          expect do
            post '/graphql', params: {
                query: query(
                    email: "not_existing@valid.com",
                    password: "87654321"
                )
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys

            expect(result.dig(:errors, 0, :message)).to eq("User not registered on this application")
            expect(result.dig(:data, :signIn)).to be_blank
          end
        end

        def query(email:, password:)
          <<-GRAPHQL
            mutation {
              signInUser(input: {
                  email: "#{email}"
                  password: "#{password}"
                }
              ) {
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
end