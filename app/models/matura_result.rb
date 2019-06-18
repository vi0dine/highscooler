class MaturaResult < ApplicationRecord
  enum level: %i[basic advanced]
  validates :level, :result, presence: true
  validates_inclusion_of :result, in: 0..100, on: :create
  belongs_to :matura_subject
  belongs_to :user
end
