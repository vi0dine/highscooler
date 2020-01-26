require 'rails_helper'

module Queries
  module FieldsOfStudy
    RSpec.describe FieldsOfStudy, type: :request do
      describe '.resolve' do
        it 'returns all fields of study' do
          user = create(:user, role: 'schoolboy')
          create_list(:field_of_study, 10)

          post '/graphql',
               params: {
                   query: query
               },
               headers: {
                   Authorization: "Bearer #{user.authentication_token}"
               }

          result = JSON.parse(response.body).to_h.deep_symbolize_keys
          expect(result.dig(:data, :fields)).to include(id: be_present,
                                                        name: be_present,
                                                        description: be_present
                                                )
          expect(result.dig(:data, :fields).count).to eq(10)
        end

        def query()
          <<-GRAPHQL
            query fields {
              fields {
                id
                name
                description
              }
            }
          GRAPHQL
        end
      end
    end
  end
end