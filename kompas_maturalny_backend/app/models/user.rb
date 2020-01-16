# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  enum gender: %i[female male]
  enum role: %i[schoolboy student partner admin]

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
end
