class MaturaResult < ApplicationRecord
  enum level: %i[basic advanced]
  belongs_to :user, optional: true
end
