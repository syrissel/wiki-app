class User < ApplicationRecord

	def fullname
		self.first_name + ' ' + self.last_name
	end

	has_many :drafts
	belongs_to :user_level
  has_many :pages, dependent: :nullify
  has_many :notifications
	belongs_to :user_status
	has_many :comments
	has_many :page_forums
	has_many :page_forums, through: :comments
  accepts_nested_attributes_for :user_level
  has_secure_password

	paginates_per 20

	validates_uniqueness_of :username
	validates :username, presence: true, length: { minimum: 5 }, format: { without: /\s/, message: "must not contain spaces" }
	validates :password, presence: true, length: { minimum: 5 }, on: :create
	validates :first_name, presence: true
	validates :last_name, presence: true

	scope :supervisors, -> {where('user_level_id > ?', INTERN_VALUE)}
	scope :only_supervisors, -> { where(user_level_id: SUPERVISOR_VALUE) }
	scope :executives, -> { where(user_level_id: EXECUTIVE_VALUE) }
end
