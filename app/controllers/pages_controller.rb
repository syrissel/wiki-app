class PagesController < ApplicationController
  before_action :authenticate_supervisor, only: [:review]
  before_action :authenticate_user, except: [:index]
  before_action :check_page_approved, only: [:show]
  

  def index
    if params[:query].present?
      @query = params[:query]
      @pages = Page.joins(:user).where("approval_status_id = #{EXECUTIVE_VALUE} AND title LIKE '%#{@query}%'
                           OR approval_status_id = #{EXECUTIVE_VALUE} AND username LIKE '%#{@query}%'").order("updated_at desc").limit(10)
    else
      @pages = Page.where("approval_status_id = ?", EXECUTIVE_VALUE).order("updated_at desc").limit(10)
    end
    
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    
    if (@page.update(page_params))
			
      redirect_to @page
      flash[:notice] = 'Wiki was updated.'
    else
      render 'edit'
    end   
	end
	
	# Need the review columns to be deleted when the wiki is approved to save space in the database.
	def executive_update
    @page = Page.find(params[:id])
    
		if (@page.update(page_params))
			
      redirect_to @page
      flash[:notice] = 'Wiki was updated.'
    else
      render 'edit'
    end   
  end

  # Instantiates new Page object with permitted values. Duplicate content is stored
  # in the table until it is approved. When it is approved, the update will be called
  # and the review columns will be set to nil perserving space in the DB.
  def create

    @page = Page.new(page_params)
    
    if (@page.save)

      @page.title_review = @page.title
      @page.content_review = @page.content
      @page.category_review = @page.category_id
      @page.save
      redirect_to page_path(@page)
      flash[:notice] = 'Wiki created.'
    else
      render 'new'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    redirect_to review_path
    @page.destroy
  end

  # Review this
  def review
    @pending_pages = Page.where(approval_status_id: [PENDING, SUPERVISOR_VALUE, REJECTED]).order("updated_at desc")
	end
	
	def review_wiki
		@page = Page.find(params[:id])
  end
  
  def preview(page)

    text = page.content
    words = text.split(" ")
    result = ""
    
    words.each do |w|
      result += " #{w}" if result.size + w.size < 400
    end

    result += "..."
  end
  helper_method :preview

  # def verify_not_same_reviewer
  #   @page = Page.find(params[:id])
  #   if @page.user_id == current_user.id
  #     unless current_user.user_level_id == EXECUTIVE_VALUE
  #       redirect_to review_path, alert: "Cannot review a page you created!"
  #     end
  #   end
  # end
  # helper_method :verify_not_same_reviewer

  private 

  def page_params
		params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id,
																 :title_review, :content_review, :category_review, :last_user_edit, 
																 :pinned, :search)
		#params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id)
  end

  def check_page_approved
    @page = Page.find(params[:id])

    if current_user.user_level_id == INTERN_VALUE && @page.approval_status_id != EXECUTIVE_VALUE
      redirect_to root_path, alert: "Page has not been approved yet."
    end
  end
end
