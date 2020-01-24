require 'rails_helper'

module Queries
  module Academies
    RSpec.describe Academy, type: :request do
      it 'returns academy data with given ID' do
        let(:academy) { create(:academy) }
        let(:academy_id) { academy.id }

        expect do
          post '/graphql', params: {
              query: query
          }

          result = JSON.parse(response.body).to_h.deep_symbolize_keys
          expect(result.dig(:data, :academy)).to include( id: be_present,
                                                          name: be_present,
                                                          description: be_present,
                                                          city: be_present
                                                        )
          expect(result.dig(:data, :academy).count).to eq(1)
          expect(result.dig(:data, :academy).id).to eq(academy_id)
        end
      end
    end
  end
end