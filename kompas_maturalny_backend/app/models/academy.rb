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
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {number_of_shards: 1} do
    mappings dynamic: 'false' do
      indexes :name
      indexes :description
      indexes :city
    end
  end

  has_many :academy_fields
  has_many :field_of_studies, through: :academy_fields
  has_many :reviews, through: :academy_fields

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :description,
            presence: true
  validates :city,
            presence: true

  def self.search(q)
    self.__elasticsearch__.search(
        {
            "query": {
                "multi_match": {
                    "query": q,
                    "type": "phrase_prefix",
                    "fields": ["name^2", "description", "city^2"]
                }
            }
        }
    )
  end
end
