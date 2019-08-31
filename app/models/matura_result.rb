class MaturaResult < ApplicationRecord
  enum level: %i[basic advanced]
  validates :level, :result, presence: true
  validates_inclusion_of :result, in: 0..100, on: :create
  belongs_to :matura_subject
  belongs_to :user

  def basic?
    level == 'basic'
  end

  def advanced?
    level == 'advanced'
  end

  def basic_subject?(subject)
    (matura_subject.name + '_Pp').include?(subject)
  end

  def advanced_subject?(subject)
    (matura_subject.name + '_Pr').include?(subject)
  end
end
