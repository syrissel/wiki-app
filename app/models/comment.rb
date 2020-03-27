class Comment < ApplicationRecord
  belongs_to :user
	belongs_to :page_forum
	has_one :notification
end
