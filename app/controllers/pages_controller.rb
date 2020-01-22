class PagesController < ApplicationController
  before_action :authenticate_supervisor, only: [:review]
  before_action :authenticate_user, except: [:index]
  before_action :check_page_approved, only: [:show]
  

  def index
    if params[:query].present?
      @query = params[:query]
      @pages = Page.joins(:user).where("approval_status_id = :executive AND sanitized_content LIKE :query
                                        OR approval_status_id = :executive AND title LIKE :query
                                        OR approval_status_id = :executive AND username LIKE :query
                                        OR approval_status_id = :executive AND description LIKE :query", 
                                        executive: EXECUTIVE_VALUE, query: "%#{@query}%" ).order("updated_at desc").limit(10)
    else
      @pages = Page.where("approval_status_id = ?", EXECUTIVE_VALUE).order("updated_at desc").limit(10)
    end
    
  end

  def new
    @videos = Video.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  # If the database fails at updating, render edit page. Otherwise commit changes.
  def base_update
    @page = Page.find(params[:id])
    @page.update(page_params)
  end

  # For user edits.
  def update
    if base_update
      redirect_to root_path, notice: 'Edit successful. Submitted for review!'
    else
      render 'edit'
    end
  end
  
  # These methods may be able to be refactored into one. See approval statuses with switch statement.
  def supervisor_update
    base_update
    redirect_to review_path, notice: 'Status updated!'
  end

	# For Executive Approval, or when the wiki is published live.
	def executive_update
    base_update
    redirect_to root_path, notice: "#{@page.title} is now live!"
  end

  # Instantiates new Page object with permitted values. Duplicate content is stored
  # in the table until it is approved. When it is approved, the update will be called
  # and the review columns will be set to nil perserving space in the DB.
  def create

    @page = Page.new(page_params)
    
    if (@page.save)

      @page.title_review = @page.title
      @page.content_review = @page.content
      @page.sanitized_content = ActionController::Base.helpers.strip_tags(@page.content)
      @page.category_review = @page.category_id
      @page.save
      flash[:notice] = 'Wiki has been submitted for review!'
      redirect_to pages_path
    else
      render 'new'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    redirect_to review_path, notice: "#{@page.title} deleted."
    @page.destroy
  end

  # Review this
  def review
    @pending_pages = Page.where(approval_status_id: [PENDING, SUPERVISOR_VALUE, REJECTED]).order("updated_at desc")
	end
	
	def review_wiki
		@page = Page.find(params[:id])
  end
  
  # Displays preview card of wiki on homepage. Finds first occurence of <p> tag
  # then substrings it upto 400 characters. Appends three dots to the end of the
  # paragraph.
  def preview(page)
    text = page.content

    if text.index("p>").nil?
      result = "No preview available"
    else
      content = text.index("p>") + 2
      result = text[content...400]
    end
    
    result += "..."
  end
  helper_method :preview

  private 

  def page_params
		params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id,
																 :title_review, :content_review, :category_review, :last_user_edit, 
																 :pinned, :search, :image, :description, :sanitized_content)
		#params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id)
  end

  def check_page_approved
    @page = Page.find(params[:id])

    if current_user.user_level_id == INTERN_VALUE && @page.approval_status_id != EXECUTIVE_VALUE
      redirect_to root_path, alert: "Page has not been approved yet."
    end
  end
end
