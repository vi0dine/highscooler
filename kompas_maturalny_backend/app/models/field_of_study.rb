# == Schema Information
#
# Table name: field_of_studies
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class FieldOfStudy < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {number_of_shards: 1} do
    mappings dynamic: 'false' do
      indexes :name
      indexes :description
    end
  end

  has_many :academy_fields
  has_many :academies, through: :academy_fields
  has_many :reviews, through: :academy_fields
  has_many :user_fields
  has_many :users, through: :user_fields

  validates :name,
            presence: true,
            uniqueness: {
                case_sensitive: false
            }
  validates :description,
            presence: true

  def most_frequent_subjects
    occurrences = Hash.new(0)
    self.academy_fields.map do |af|
      af.subjects
    end.flatten.each do |subject|
      occurrences[subject.name] += 1
    end

    {
        subjects:
            occurrences
                .sort_by { |_k, v| -v }
                .first(4)
                .map { |k, v| {subject: k, count: v} },
        total: occurrences.values.reduce { |v, acc| acc + v }
    }
  end

  def self.search(q)
    self.__elasticsearch__.search(
        {
            "query": {
                "multi_match": {
                    "query": q,
                    "type": "phrase_prefix",
                    "fields": ["name^2", "description"]
                }
            }
        }
    )
  end
end
