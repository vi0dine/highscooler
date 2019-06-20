class Academy < ApplicationRecord
  validates :name, :city, :academy_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
