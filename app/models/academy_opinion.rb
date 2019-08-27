class AcademyOpinion < ApplicationRecord
  validates :body, :is_positive, presence: true
  belongs_to :user
  belongs_to :academy
end
