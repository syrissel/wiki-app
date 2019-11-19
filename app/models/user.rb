class User < ApplicationRecord
  belongs_to :user_level
  accepts_nested_attributes_for :user_level
  has_secure_password

  # attr_accessible :username, :password, :password_confirmation

  validates_uniqueness_of :username
end
