FactoryBot.define do
  factory :academy do
    name { Faker::Educator.university }
    city { Faker::Address.city}
    academy_type { Faker::Base.rand(2) }
  end
end
