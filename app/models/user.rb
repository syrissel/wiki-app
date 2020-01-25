class User < ApplicationRecord
  belongs_to :user_level
  has_many :pages, dependent: :nullify
  belongs_to :user_status
  accepts_nested_attributes_for :user_level
  has_secure_password

	validates_uniqueness_of :username
	validates :username, presence: true, length: { minimum: 2 }, format: { with: /\A[a-z]+\z/ }
end
