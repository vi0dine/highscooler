# frozen_string_literal: true

class Interested < ApplicationRecord
  belongs_to :field_detail
  belongs_to :user
end
