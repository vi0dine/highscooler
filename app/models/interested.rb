class Interested < ApplicationRecord
  belongs_to :field_detail, counter_cache: true
  belongs_to :user, counter_cache: true
end
