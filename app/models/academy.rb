class Academy < ApplicationRecord
  enum academy_type: %i[university polytechnic music_academy medical_academy art_academy other]
  validates :name, :city, :academy_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :field_details
  has_many :field_of_studies, through: :field_details
  has_many :users

  paginates_per 5
end
