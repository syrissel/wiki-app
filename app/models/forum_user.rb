class ForumUser < ApplicationRecord
  belongs_to :page_forum
  belongs_to :user
end
