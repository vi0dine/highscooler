require 'rails_helper'

module Queries
  module FieldsOfStudy
    RSpec.describe FieldOfStudy, type: :request do
      describe '.resolve' do
        it 'returns a field of study with given ID' do
          user = create(:user, role: 'schoolboy')
          field = create(:field_of_study)
          field_id = field.id

            post '/graphql',
                 params: {
                     query: query(id: field_id)
                 },
                 headers: {
                     Authorization: "Bearer #{user.authentication_token}"
                 }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :field)).to include(  id: be_present,
                                                           name: be_present,
                                                           description: be_present
                                                )
            expect(result.dig(:data, :field, :id).to_i).to eq(field_id)
            expect(result.dig(:data).count).to eq(1)
        end

        def query(id:)
          <<-GRAPHQL
            query field {
              field (id: #{id}) {
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