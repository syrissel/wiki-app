class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @first = Category.first
    @sorted_categories = Category.order(:sort_number)
    @sub_categories = Category.order(:sort_number).where("category_id IS NOT NULL")

    root_categories = Category.where('category_id is null')
    @child_categories = Category.where('category_id is not null')
    @categories_array = []

    root_categories.each do |cat|
      @categories_array << [cat, 0]
      find_children cat, 1
    end

    render json: @categories_array
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
  end

  # Auto increment sort number.
  def sort_number_increment
    if Category.first.nil?
      1
    else
      Category.last.id + 1
    end
  end
  helper_method :sort_number_increment

  # Call this action on the move up link in the view, then redirect to index.
  def move_up
    current = Category.find(params[:id])

    

    unless (current.sort_number - 1) == 0
      current_sort_num = current.sort_number
      top_sort_num = current.sort_number - 1
      top = Category.find_by_sort_number(top_sort_num)

      current.update(sort_number: top_sort_num)
      top.update(sort_number: current_sort_num)
    end

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :sort_number)
  end

  def find_children (category, generation)
    @child_categories.each do |child|
      if child.category == category
        @categories_array << [child, generation] 
        find_children child, generation+1
      end
    end
  end
end
