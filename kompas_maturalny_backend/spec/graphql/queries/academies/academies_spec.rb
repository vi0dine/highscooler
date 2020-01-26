require 'rails_helper'

module Queries
  module Academies
    RSpec.describe Academies, type: :request do
      describe '.resolve' do
        it "returns all academies data" do
          user = create(:user, role: 'schoolboy')
          academies = create_list(:academy, 20)

          post '/graphql',
               params: {
                   query: query
               },
               headers: {
                   Authorization: "Bearer #{user.authentication_token}"
               }


          result = JSON.parse(response.body).to_h.deep_symbolize_keys
          expect(result.dig(:data, :academies)).to include(id: be_present,
                                                           name: be_present,
                                                           description: be_present,
                                                           city: be_present
                                                   )
          expect(result.dig(:data, :academies).count).to eq(20)
        end

        def query()
          <<-GRAPHQL
            query academies {
              academies {
                id
                name
                description
                city
              }
            }
          GRAPHQL
        end
      end
    end
  end
end