class Academy < ApplicationRecord
  validates :name, :city, :academy_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :field_details
  has_many :field_of_studies, through: :field_details
end
