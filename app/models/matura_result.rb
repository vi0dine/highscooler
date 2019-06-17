class MaturaResult < ApplicationRecord
  enum level: %i[basic advanced]
  validates :level, :result, presence: true
  validates :level, :result, numericality: { only_integers: true }
  belongs_to :matura_subject
  belongs_to :user
end
