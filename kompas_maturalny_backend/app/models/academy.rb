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
end
