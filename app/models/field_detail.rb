class FieldDetail < ApplicationRecord
  belongs_to :academy
  belongs_to :field_of_study
  has_many :interesteds
  has_many :users, through: :interesteds
  validates :recrutation_formula, presence: true
end
