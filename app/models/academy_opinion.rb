class AcademyOpinion < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :academy
end
