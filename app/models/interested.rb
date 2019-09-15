# frozen_string_literal: true

class Interested < ApplicationRecord
  belongs_to :field_detail
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :field_detail_id
  validates :user_id, :field_detail_id, presence: true
end
