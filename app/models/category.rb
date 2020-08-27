class Category < ApplicationRecord
  before_create :is_last_category
  before_save :is_last_category
  has_many :pages, :dependent => :destroy
	has_many :categories, -> { order(position: :asc) }, class_name: "Category", foreign_key: "category_id",
	         :dependent => :destroy
  belongs_to :category, class_name: "Category", optional: true

  validates :page_limit, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 0 }

	# Dynamic list sorting functionality.
  acts_as_list scope: :category

  category_list = Category.all

  attr_accessor :parents

  # Determine whether a category is the last possible child.
  def is_last_category
    parent1 = nil
    parent2 = nil
    parent3 = nil
    parent4 = nil
    self.parents = Array.new

    if category_id.present?
      parent1 = Category.find(category_id).present? ? Category.find(category_id) : nil
    end

    if parent1.present? && parent1.category_id.present?
      parent2 = Category.find(parent1.category_id)
    end

    if parent2.present? && parent2.category_id.present?
      parent3 = Category.find(parent2.category_id)
    end

    if parent3.present? && parent3.category_id.present?
      parent4 = Category.find(parent3.category_id)
    end
    
    if parent1.present?
      self.parents.push(parent1)
    end

    if parent2.present?
      self.parents.push(parent2)
    end

    if parent3.present?
      self.parents.push(parent3)
    end

    if parent4.present?
      self.parents.push(parent4)
    end

    if self.parents.count == 4
      self.is_leaf_node = 'true'
    else
      self.is_leaf_node = 'false'
    end

  end

  scope :no_leaf_categories, -> { where('is_leaf_node = ? OR is_leaf_node IS NULL', 'false') }
end
