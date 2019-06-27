FactoryBot.define do
  factory :academy do
    name { Faker::Educator.university }
    city { Faker::Address.city }
    academy_type { Faker::Base.rand(2) }

    factory :academy_with_field_details do
      after :create do |academy|
        create_list :field_detail, 5, academy: academy
      end
    end
  end
end
