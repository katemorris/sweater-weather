class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true, email: true
  validates :api_key, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  has_secure_password
end
