class User < ApplicationRecord
  enum gender: %i[female male not_specified]
  enum account_type: %i[schoolboy student other]
  has_many :matura_results
  has_many :study_interests
  has_many :field_of_studies, through: :study_interests
  accepts_nested_attributes_for :matura_results
  accepts_nested_attributes_for :study_interests
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :encryptable
end
