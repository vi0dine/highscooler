require 'rails_helper'

module Mutations
  module Fields
    RSpec.describe RemoveUserField, type: :request do
      describe '.resolve' do
        it 'removes UserField' do
          user = create(:user, role: 'schoolboy')
          fields = create_list(:field_of_study, 5, :with_academy_fields)

          fields.each do |field|
            UserField.create!(field_of_study: field, user: user)
          end

          post '/graphql',
               params: {
                   query: query(fields)
               },
               headers: {
                   Authorization: "Bearer #{user.authentication_token}"
               }

          result = JSON.parse(response.body).to_h.deep_symbolize_keys
          expect(result.dig(:data, :removeUserField, :userField)).to have_key(:id)
          expect(result.dig(:data, :removeUserField, :userField, :user)).to have_key(:id)
          expect(result.dig(:data, :removeUserField, :userField, :fieldOfStudy)).to have_key(:id)
        end
      end

      def query(fields)
        <<-GRAPHQL
          mutation {
            removeUserField(input: {fieldId: #{fields.sample.id}}) {
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