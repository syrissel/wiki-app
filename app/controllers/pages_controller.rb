class PagesController < ApplicationController
  before_action :authenticate_supervisor, only: [:review]
  before_action :authenticate_user, except: [:index]

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
    
    if (@page.update(title: params[:page][:title], content: params[:page][:content], approval_status_id: params[:page][:approval_status_id]))
      
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

  private 

  def page_params
    params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id)
  end
end
