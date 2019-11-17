class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]

  # User level id of 1 and 2 are Supervisor and Executive, respectively.
  def user_admin
    @users = User.where(user_level_id: [1,2])
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    
    if (@page.update(title: params[:page][:title], content: params[:page][:content]))
      
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
      redirect_to page_show(@page)
      flash[:notice] = 'Wiki created.'
    else
      render 'new'
    end
  end

  private 
  
  def page_params
    params.require(:page).permit(:title, :content)
  end
end
