# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  authentication_token            :text
#  authentication_token_created_at :datetime
#  city                            :string
#  date_of_birth                   :datetime
#  date_of_matura                  :datetime
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  gender                          :integer
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  role                            :integer
#  username                        :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    sequence(:username) { |n| "#{Faker::Internet.username}#{n}" }
    city { Faker::Address.city }
    gender { %w[male female].sample }
    role { %w[schoolboy student partner admin].sample }
    date_of_birth { Faker::Date.backward }
    date_of_matura { Faker::Date.backward }

    trait :with_matura_results do
      after(:create) do |user|
        create_list(:matura_result, 5, user: user)
      end
      end
  end
end
