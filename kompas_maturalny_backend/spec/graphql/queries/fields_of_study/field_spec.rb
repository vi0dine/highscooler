require 'rails_helper'

module Queries
  module FieldsOfStudy
    RSpec.describe FieldOfStudy, type: :request do
      describe '.resolve' do
        it 'returns a field of study with given ID' do
          user = create(:user, role: 'schoolboy')
          field = create(:field_of_study, :with_reviews)
          field_id = field.id

          post '/graphql',
               params: {
                   query: query(id: field_id)
               },
               headers: {
                   Authorization: "Bearer #{user.authentication_token}"
               }

          result = JSON.parse(response.body).to_h.deep_symbolize_keys
          expect(result.dig(:data, :field)).to include(id: be_present,
                                                       name: be_present,
                                                       description: be_present
                                               )
          expect(result.dig(:data, :field, :academies)).to all(include(id: be_present,
                                                               name: be_present,
                                                               city: be_present
                                                       ))
          expect(result.dig(:data, :field, :reviews)).to all(include(title: be_present,
                                                         body: be_present,
                                                         rate: be_present,
                                                         reviewable: be_present
                                                 ))
          expect(result.dig(:data, :field, :reviews).sample.dig(:reviewable, :academy)).to include(name: be_present,
                                                                                city: be_present,
                                                                        )
          expect(result.dig(:data, :field, :id).to_i).to eq(field_id)
          expect(result.dig(:data, :field, :academies).count).to eq(::FieldOfStudy.find(field_id).academies.count)
          expect(result.dig(:data, :field, :reviews).count).to eq(::FieldOfStudy.find(field_id).reviews.count)
        end

        def query(id:)
          <<-GRAPHQL
            query field {
              field(id: #{id}) {
                id
                name
                description
                academies {
                  id
                  name
                  city
                }
                reviews {
                  title
                  body
                  rate
                  reviewable {
                    academy {
                      name
                      city
                    }
                  }
                }
              }
            }
          GRAPHQL
        end
      end
    end
  end
end