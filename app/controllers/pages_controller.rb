class PagesController < ApplicationController
  before_action :authenticate_supervisor, only: [:review]
  before_action :authenticate_user, except: [:index]
  before_action :check_page_approved, only: [:show]
  

  def index
    @pages = Page.where("approval_status_id = ?", EXECUTIVE_VALUE)
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
			
			@page.title_review = nil
			@page.content_review = nil
			@page.category_review = nil
			@page.save
			
      redirect_to @page
      flash[:notice] = 'Wiki was updated.'
    else
      render 'edit'
    end   
  end

  # Instantiates new Page object with permitted values: title and content.
  def create

    @page = Page.new(page_params)

    if (@page.save)
      redirect_to page_path(@page)
      flash[:notice] = 'Wiki created.'
    else
      render 'new'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    redirect_to pages_path
    @page.destroy
  end

  # Review this
  def review
    @pending_pages = Page.where(approval_status_id: [PENDING, SUPERVISOR_VALUE, REJECTED])
	end
	
	def review_wiki
		@page = Page.find(params[:id])
	end

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
		#params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id, :title_review, :content_review, :category_review, :last_user_edit)
		params.require(:page).permit(:approval_status_id, :user_id, :title_review, :content_review, :category_id)
  end

  def check_page_approved
    @page = Page.find(params[:id])

    if current_user.user_level_id == INTERN_VALUE && @page.approval_status_id != EXECUTIVE_VALUE
      redirect_to root_path, alert: "Page has not been approved yet."
    end
  end
end
