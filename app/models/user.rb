# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :results

  enum gender: %i[female male not_specified]
  enum account_type: %i[schoolboy student partner admin]
  validates :username, :email, :encrypted_password, :account_type, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  has_many :matura_results
  has_many :study_interests
  has_many :matura_subjects, -> { distinct }, through: :matura_results
  has_many :field_of_studies, through: :study_interests
  has_many :field_details, through: :field_of_studies
  has_many :academy_opinions
  has_many :field_opinions
  has_many :interesteds
  belongs_to :high_school, optional: true
  belongs_to :field_of_study, optional: true
  belongs_to :academy, optional: true
  accepts_nested_attributes_for :matura_results
  accepts_nested_attributes_for :study_interests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :encryptable

  def formulas
    field_details.collect(&:recrutation_formula)
  end
end
