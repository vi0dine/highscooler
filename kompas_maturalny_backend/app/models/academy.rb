# == Schema Information
#
# Table name: academies
#
#  id          :bigint           not null, primary key
#  city        :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Academy < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :description,
            presence: true
  validates :city,
            presence: true
end
