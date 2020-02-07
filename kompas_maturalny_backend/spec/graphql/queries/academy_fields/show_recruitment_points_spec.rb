require 'rails_helper'

module Queries
  module AcademyFields
    RSpec.describe "ShowRecruitmentPoints", type: :request do
      it 'returns recruitment points' do
        user = create(:user, :with_matura_results, role: 'schoolboy')
        field = create(:field_of_study, :with_academy_fields)
        academy_field = field.academy_fields.sample

        post '/graphql',
             params: {
                 query: query(id: academy_field.id)
             },
             headers: {
                 Authorization: "Bearer #{user.authentication_token}"
             }

        result = JSON.parse(response.body).to_h.deep_symbolize_keys
        $stderr.puts result
        expect(result.dig(:data, :recruitmentPoints)).to be_kind_of(Numeric)
        expect(result.dig(:data, :recruitmentPoints)).to eq(
                                                             academy_field.calculate_recruitment_points_for(user)
                                                         )
      end

      def query(id:)
        <<-GRAPHQL
          query recruitment_points {
              recruitmentPoints(id: #{id})
            }
        GRAPHQL
      end
    end
  end
end