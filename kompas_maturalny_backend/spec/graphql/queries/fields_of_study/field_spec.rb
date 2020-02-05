require 'rails_helper'

module Queries
  module FieldsOfStudy
    RSpec.describe FieldOfStudy, type: :request do
      before do
        puts "Seeding matura subjects"
        MaturaSubject.create(name: 'Chemia', level: 'advanced', subject_type: 'sciences')
        MaturaSubject.create(name: 'Biologia', level: 'advanced', subject_type: 'sciences')
        MaturaSubject.create(name: 'Fizyka', level: 'advanced', subject_type: 'sciences')
        MaturaSubject.create(name: 'Informatyka', level: 'advanced', subject_type: 'sciences')
        MaturaSubject.create(name: 'Geografia', level: 'advanced', subject_type: 'sciences')
        MaturaSubject.create(name: 'Historia', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Wiedza o społeczeństwie', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Matematyka', level: 'advanced', subject_type: 'sciences')
        MaturaSubject.create(name: 'Matematyka', level: 'basic', subject_type: 'sciences')
        MaturaSubject.create(name: 'Polski', level: 'basic', subject_type: 'humanities')
        MaturaSubject.create(name: 'Polski', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Angielski', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Angielski', level: 'basic',  subject_type: 'humanities')
        MaturaSubject.create(name: 'Niemiecki', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Niemiecki', level: 'basic',  subject_type: 'humanities')
        MaturaSubject.create(name: 'Francuski', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Francuski', level: 'basic', subject_type: 'humanities')
        MaturaSubject.create(name: 'Hiszpański', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Hiszpański', level: 'basic', subject_type: 'humanities')
        MaturaSubject.create(name: 'Rosyjski', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Rosyjski', level: 'basic', subject_type: 'humanities')
        MaturaSubject.create(name: 'Włoski', level: 'advanced', subject_type: 'humanities')
        MaturaSubject.create(name: 'Włoski', level: 'basic', subject_type: 'humanities')
        MaturaSubject.create(name: 'Łaciński i kultura antyczna', level: 'advanced', subject_type: 'humanities')
      end

      describe '.resolve' do
        it 'returns a field of study with given ID' do
          user = create(:user, role: 'schoolboy')
          field = create(:field_of_study, :with_reviews, :with_academy_fields)
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
                                                       description: be_present,
                                                       mostFrequentSubjects: be_present
                                               )
          expect(result.dig(:data, :field, :academies)).to all(include(id: be_present,
                                                                       name: be_present,
                                                                       city: be_present
                                                               ))
          expect(result.dig(:data, :field, :reviews)).to all(include(title: be_present,
                                                                     body: be_present,
                                                                     rate: be_present,
                                                                     createdAt: be_present,
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
                mostFrequentSubjects
                academies {
                  id
                  name
                  city
                }
                reviews {
                  title
                  body
                  rate
                  createdAt
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