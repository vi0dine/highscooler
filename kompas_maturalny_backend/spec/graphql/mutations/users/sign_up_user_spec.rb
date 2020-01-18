require 'rails_helper'

module Mutations
  module Users
    RSpec.describe SignUpUser, type: :request do
      describe '.resolve' do
        it 'creates an user with default role' do
          user = build(:user)

          expect do
            post '/graphql', params: {
                query: query(
                    username: user.username,
                    email: user.email,
                    password: user.password
                )
            }
          end.to change { User.count }.by(1)

        end

        it 'returns a user data with default role' do
          user = build(:user)

          expect do
            post '/graphql', params: {
                query: query(
                    username: user.username,
                    email: user.email,
                    password: user.password
                )
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :signUpUser)).to include(
                                id: be_present,
                                username: user.username,
                                email: user.email,
                                role: 'schoolboy',
                                authenticationToken: be_present
                            )
          end
        end

        it "raises error for RecordInvalid" do
          user = build(:user, email: nil)

          user = User.new
          user.validate
          allow(User).to receive(:create!).
              and_raise(ActiveRecord::RecordInvalid.new(user))

          expect do
            post '/graphql', params: {
                query: query(
                    username: user.username,
                    email: user.email,
                    password: user.password
                )
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys

            expect(result[:errors]).to_not be_blank
            expect(result.dig(:errors, 0, :message)).
                to include(user.errors.full_messages.first)
          end


        end

        def query(username:, email:, password:)
          <<-GRAPHQL
            mutation {
              signUpUser(input: {
                  username: "#{username}"
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