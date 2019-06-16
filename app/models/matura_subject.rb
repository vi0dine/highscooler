class MaturaSubject < ApplicationRecord
  enum subject_type: %i[humanities sciences]
  has_many :matura_results
end
