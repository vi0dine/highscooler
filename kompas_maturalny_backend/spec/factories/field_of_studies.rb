# frozen_string_literal: true

# == Schema Information
#
# Table name: field_of_studies
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#


FactoryBot.define do
  factory :field_of_study do
    sequence(:name) { |n| "#{Faker::Educator.course_name} #{n}" }
    description { Faker::Lorem.sentences }

    trait :with_reviews do
      after :create do |field|
        create_list(:review, 5, reviewable: create(:academy_field, field_of_study: field))
      end
    end
  end
end
