class FieldDetail < ApplicationRecord
  belongs_to :academy
  belongs_to :field_of_study
  validates :recrutation_formula, presence: true
end
