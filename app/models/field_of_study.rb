class FieldOfStudy < ApplicationRecord
  enum type: %i[humanities social_sciences natural_sciences formal_sciences professions]
  has_many :study_interests
  has_many :users, through: :study_interests
end
