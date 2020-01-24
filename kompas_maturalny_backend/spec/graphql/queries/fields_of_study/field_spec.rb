require 'rails_helper'

module Queries
  module FieldsOfStudy
    RSpec.describe FieldOfStudy, type: :request do
      describe '.resolve' do
        it 'returns a field of study with given ID' do
          field = create(:field_of_study)
          field_id = field.id

          expect do
            post '/graphql', params: {
                query: query(id: field_id)
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :field)).to include(  id: be_present,
                                                           name: be_present,
                                                           description: be_present
                                                )
            expect(result.dig(:data, :field, :id).count).to eq(field_id)
            expect(result.dig(:data, :field).count).to eq(1)
          end
        end

        def query(id:)
          <<-GRAPHQL
            query field(id: #{id}) {
              field {
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