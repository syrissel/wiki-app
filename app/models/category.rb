class Category < ApplicationRecord
  has_many :pages
  has_many :categories, -> { order(position: :asc) }, class_name: "Category", foreign_key: "category_id"
  belongs_to :category, class_name: "Category", optional: true

  acts_as_list scope: :category

  category_list = Category.all
end
