# frozen_string_literal: true

FactoryBot.define do
  factory :matura_subject do
    sequence(:name) { |n| "#{Faker::Educator.subject} #{n}" }
    subject_type { Faker::Base.rand(2) }
  end
end
