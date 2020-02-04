require 'rails_helper'

module Queries
  module Academies
    RSpec.describe Academy, type: :request do
      it 'returns academy data with given ID' do
        user = create(:user, role: 'schoolboy')
        academy = create(:academy)
        academy_id = academy.id

        post '/graphql',
             params: {
                 query: query(id: academy_id)
             },
             headers: {
                 Authorization: "Bearer #{user.authentication_token}"
             }

        result = JSON.parse(response.body).to_h.deep_symbolize_keys
        expect(result.dig(:data, :academy)).to include(id: be_present,
                                                       name: be_present,
                                                       description: be_present,
                                                       city: be_present
                                               )
        expect(result.dig(:data, :academy, :fieldOfStudies)).to all(include(id: be_present,
                                                                            name: be_present,
                                                                            description: be_present
                                                                    ))
        expect(result.dig(:data, :academy, :reviews)).to all(include(title: be_present,
                                                                     body: be_present,
                                                                     rate: be_present,
                                                                     reviewable: be_present
                                                             ))
        expect(result.dig(:data, :academy, :reviews).sample.dig(:reviewable, :fieldOfStudy)).to include(name: be_present)
        expect(result.dig(:data, :academy, :id).to_i).to eq(academy_id)
        expect(result.dig(:data, :academy, :fieldOfStudies).count).to eq(::Academy.find(academy_id).field_of_studies.count)
        expect(result.dig(:data, :academy, :reviews).count).to eq(::Academy.find(academy_id).reviews.count)
      end

      def query(id:)
        <<-GRAPHQL
          query academy{
            academy(id: #{id}) {
              id
              name
              description
              city
              fieldOfStudies {
                id
                name
                description
              }
              reviews {
                title
                body
                rate
                reviewable {
                  fieldOfStudy {
                    name
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