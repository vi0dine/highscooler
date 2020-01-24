require 'rails_helper'

module Queries
  module Academies
    RSpec.define Academies, type: :request do
      describe '.resolve' do
        it "returns all academies data" do
          let(:academies) { create_list(:academy, 20) }

          expect do
            post '/graphql', params: {
                query: query
            }

            result = JSON.parse(response.body).to_h.deep_symbolize_keys
            expect(result.dig(:data, :academies)).to include( id: be_present,
                                                              name: be_present,
                                                              description: be_present,
                                                              city: be_present
                                                  )
            expect(result.dig(:data, :academies).count).to eq(10)
          end
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