class User < ApplicationRecord
  enum gender: %i[female male not_specified]
  enum account_type: %i[schoolboy student other]
  has_many :matura_results
  accepts_nested_attributes_for :matura_results
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :encryptable
end
