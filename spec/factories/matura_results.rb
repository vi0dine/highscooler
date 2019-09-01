# frozen_string_literal: true

FactoryBot.define do
  factory :matura_result do
    level { Faker::Base.rand(2) }
    result { Faker::Base.rand(100) }
    user
    matura_subject
  end
end
