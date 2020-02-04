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

class FieldOfStudy < ApplicationRecord
  has_many :academy_fields
  has_many :academies, through: :academy_fields
  has_many :reviews, through: :academy_fields

  validates :name,
            presence: true,
            uniqueness: {
                case_sensitive: false
            }
  validates :description,
            presence: true
end
