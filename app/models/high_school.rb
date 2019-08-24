class HighSchool < ApplicationRecord
  enum school_type: %i[general technological other] 
  has_many :users
  validates :name, :city, :school_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
