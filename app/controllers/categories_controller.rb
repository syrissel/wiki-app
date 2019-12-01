class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def index
    @first = Category.first
    @sorted_categories = Category.order(:sort_number)
    @sub_categories = Category.order(:sort_number).where("category_id IS NOT NULL")

    @categories = Category.order(position: :asc).arrange_as_array
    # @categories = Category.arrange(:order => :id)
    
    render json: @categories

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
    current.move_higher
    # current = Category.find(params[:id])

    # unless (current.sort_number - 1) == 0
    #   current_sort_num = current.sort_number
    #   top_sort_num = current.sort_number - 1
    #   top = Category.find_by_sort_number(top_sort_num)

    #   current.update(sort_number: top_sort_num)
    #   top.update(sort_number: current_sort_num)
    # end

    redirect_to categories_path
  end

  def move_down
    current = Category.find(params[:id])
    current.move_lower

    redirect_to categories_path
  end


  private

  def category_params
    params.require(:category).permit(:name, :sort_number)
  end
end
