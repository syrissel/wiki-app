class Category < ApplicationRecord
  has_many :pages, :dependent => :destroy
	has_many :categories, -> { order(position: :asc) }, class_name: "Category", foreign_key: "category_id",
	         :dependent => :destroy
  belongs_to :category, class_name: "Category", optional: true

	# Dynamic list sorting functionality.
  acts_as_list scope: :category

  category_list = Category.all
end
