class User < ApplicationRecord

	def fullname
		self.first_name + ' ' + self.last_name
	end

  belongs_to :user_level
  has_many :pages, dependent: :nullify
  has_many :notifications
	belongs_to :user_status
	has_many :comments
	has_many :page_forums
	has_many :page_forums, through: :comments
  accepts_nested_attributes_for :user_level
  has_secure_password

	validates_uniqueness_of :username
	validates :username, presence: true, length: { minimum: 2 }, format: { with: /\A[a-z]+\z/ }
	validates :password, presence: true, length: { minimum: 5 }, on: :create

	scope :supervisors, -> {where('user_level_id > ?', INTERN_VALUE)}
end
