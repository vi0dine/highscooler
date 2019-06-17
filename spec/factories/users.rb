FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { '123456' }
    city { 'Warsaw' }
    date_of_birth { '1999-08-13' }
    gender { 1 }
    account_type { 2 }
    date_of_matura { '2016-07-03' }

    factory :user_with_interests do
      after :create do |user|
        create_list :study_interest, 3, user: user
      end
    end

    factory :user_with_results do
      after :create do |user|
        create_list :matura_result, 5, user: user
      end
    end
  end
end
