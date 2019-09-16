# frozen_string_literal: true

class Academy < ApplicationRecord
  enum academy_type: %i[university polytechnic music_academy medical_academy art_academy other]
  validates :name, :city, :academy_type, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  has_many :users
  has_many :field_details
  has_many :field_of_studies, through: :field_details
  has_many :academy_opinions
  has_many :field_opinions, through: :users

  paginates_per 5

  def interested_users_count
    field_details.sum(&:interested_users_count)
  end

  def interested_users_count_of_field(field)
    field_details.select { |f| f.field_of_study == field }.first.interested_users_count
  end
end
