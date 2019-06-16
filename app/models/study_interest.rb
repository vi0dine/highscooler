class StudyInterest < ApplicationRecord
  belongs_to :field_of_study
  belongs_to :user
end
