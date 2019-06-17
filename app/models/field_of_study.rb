class FieldOfStudy < ApplicationRecord
  enum type: %i[humanities social_sciences natural_sciences formal_sciences professions others]
  validates :name, :field_type, presence: true
  validates :field_type, numericality: { only_integers: true } 
  validates :name, uniqueness: { case_sensitive: false }
  has_many :study_interests
  has_many :users, through: :study_interests
end
