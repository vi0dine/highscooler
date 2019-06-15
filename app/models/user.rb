class User < ApplicationRecord
  enum account_type: %i[schoolboy student other]
  enum gender: %i[female male]
  has_secure_password
end
