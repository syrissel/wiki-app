class PagesController < ApplicationController

  def show
    @page = Page.find(params[:id])
  end

  # Instantiates new Page object with permitted values: title and content.
  def create

    @page = Page.new(page_params)

    if (@page.save)
      redirect_to @page
    else
      render 'new'
    end
  end

  private def page_params
    params.require(:page).permit(:title, :content)
  end
end
