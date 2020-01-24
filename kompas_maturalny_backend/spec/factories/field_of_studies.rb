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
  end
end
