# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  authentication_token            :text
#  authentication_token_created_at :datetime
#  city                            :string
#  date_of_birth                   :datetime
#  date_of_matura                  :datetime
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  gender                          :integer
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  role                            :integer
#  username                        :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  include GraphQl::Interface
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :matura_results
  has_many :matura_subjects, through: :matura_results

  # ENABLE DEEP COPY CREATION
  amoeba do
    enable
  end

  enum role: %i[schoolboy student partner admin]
  enum gender: %i[female male]

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :encrypted_password,
            presence: true

  validates :role,
            presence: true
end
