require 'rails_helper'

module Mutations
  module Fields
    RSpec.describe AddUserField, type: :request do
      describe '.resolve' do
        it 'creates new UserField' do
          user = create(:user, role: 'schoolboy')
          fields = create_list(:field_of_study, 5, :with_academy_fields)

          post '/graphql',
               params: {
                   query: query(fields)
               },
               headers: {
                   Authorization: "Bearer #{user.authentication_token}"
               }

          result = JSON.parse(response.body).to_h.deep_symbolize_keys
          $stderr.puts result.dig(:data, :addUserField, :userField).has_key?(:id)
          expect(result.dig(:data, :addUserField, :userField)).to have_key(:id)
          expect(result.dig(:data, :addUserField, :userField, :user)).to have_key(:id)
          expect(result.dig(:data, :addUserField, :userField, :fieldOfStudy)).to have_key(:id)
        end
      end

      def query(fields)
        <<-GRAPHQL
          mutation {
            addUserField(input: {fieldId: #{fields.sample.id}}) {
              userField {
                id
                fieldOfStudy {
                  id
                }
                user {
                  id
                }
              }
            }
          }
        GRAPHQL
      end
    end
  end
end