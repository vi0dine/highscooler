class MaturaSubject < ApplicationRecord
  enum subject_type: %i[humanities sciences]
  validates :name, :subject_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :subject_type, numericality: { only_integer: true }
  has_many :matura_results
end
