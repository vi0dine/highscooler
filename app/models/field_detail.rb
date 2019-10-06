# frozen_string_literal: true

class FieldDetail < ApplicationRecord
  belongs_to :academy, counter_cache: :field_of_studies_count
  belongs_to :field_of_study, counter_cache: :academies_count
  has_many :interesteds
  has_many :users, through: :interesteds
  validates :recrutation_formula, presence: true
  validates_format_of :recrutation_formula, with: /\[\(.*\)\]/, on: :create, message: "is invalid"
  validates_uniqueness_of :field_of_study_id, scope: :academy_id

  def name
    field_of_study.name
  end
end
