class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :page_forum
end
