FactoryBot.define do
  factory :user do
    username { "viodine" }
    email { "viodine@yahoo.com" }
    password_digest { "12345" }
    date_of_birth { "2019-06-15" }
    gender { 1 }
    city { "Wrocław" }
    account_type { 1 }
    date_of_matura { "2016-07-03" }
  end
end
