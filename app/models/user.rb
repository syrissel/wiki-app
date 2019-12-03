class User < ApplicationRecord
  belongs_to :user_level
  has_many :pages, dependent: :nullify
  accepts_nested_attributes_for :user_level
  has_secure_password

  validates_uniqueness_of :username
end
