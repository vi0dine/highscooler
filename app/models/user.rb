class User < ApplicationRecord
  enum gender: %i[female male not_specified]
  enum account_type: %i[schoolboy student other]
  validates :username, :email, :encrypted_password, :account_type, presence: true
  validates :username, :email, uniqueness: { case_sensitive: false }
  has_many :matura_results
  has_many :study_interests
  has_many :matura_subjects, -> { distinct }, through: :matura_results
  has_many :field_of_studies, through: :study_interests
  belongs_to :high_school
  accepts_nested_attributes_for :matura_results
  accepts_nested_attributes_for :study_interests

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :encryptable
end
