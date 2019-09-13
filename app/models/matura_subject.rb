# frozen_string_literal: true

class MaturaSubject < ApplicationRecord
  enum subject_type: %i[humanities sciences others]
  validates :name, :subject_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :matura_results
end
