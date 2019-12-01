class Category < ApplicationRecord
  has_ancestry
  has_many :pages
  has_many :categories, -> { order(position: :asc) }, class_name: "Category", foreign_key: "category_id"
  belongs_to :category, class_name: "Category", optional: true

  acts_as_list scope: [:ancestry]

  category_list = Category.all

  def self.arrange_as_array(options={}, hash=nil)                                                                                                                                                            
    hash ||= arrange(options)

    arr = []
    hash.each do |node, children|
      arr << node
      arr += arrange_as_array(options, children) unless children.empty?
    end
    arr
  end
end
