class HighSchool < ApplicationRecord
  enum school_type: %i[general technological others] 
  has_many :users
  validates :name, :city, :school_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :school_type, numericality: { only_integers: true }
end
