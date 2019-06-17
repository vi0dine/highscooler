FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { 'John123' }
    password { '123456' }
    city { 'Warsaw' }
    date_of_birth { '1999-08-13' }
    gender { 1 }
    account_type { 2 }
    date_of_matura { '2016-07-03' }
  end
end
