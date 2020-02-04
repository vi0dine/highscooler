# == Schema Information
#
# Table name: academies
#
#  id          :bigint           not null, primary key
#  city        :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :academy do
    sequence(:name) { |n| "#{Faker::Educator.university} #{n}" }
    description { Faker::Lorem.sentences }
    city { Faker::Address.city }

    after :create do |academy|
      create_list(:review, 5, reviewable: create(:academy_field, academy: academy))
    end
  end
end
