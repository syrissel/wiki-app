class CategoriesController < ApplicationController
  before_action :authenticate_supervisor, except: [ :show ]
  before_action :authenticate_user
  before_action :set_category, only: [:edit, :show, :update, :destroy]

  def new
    @category = Category.new

    if params[:id].present?
      @parent = Category.find(params[:id])
    end
  end

  def index
    @first = Category.first
    # @sub_categories = Category.order(:position).where("category_id IS NOT NULL")
    # @root_categories = Category.order(:position).where("category_id IS NULL")

  end

  def show
    @category = Category.find(params[:id])
    @pages = @category.pages.where(page_publish_status_id: PUBLISHED).order(updated_at: :desc).page params[:page]
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "#{@category.name} saved."
    else
      render :edit
    end
  end

	def destroy
    redirect_to categories_path, notice: "#{@category.name} has been deleted"
		@category.destroy
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

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :position, :category_id, :page_limit)
  end
end
