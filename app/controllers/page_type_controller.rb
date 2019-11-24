class PageTypeController < ApplicationController
  before_action :authenticate_supervisor

  def new
    @page_type = PageType.new
  end

  def create
    @page_type = PageType.new(page_type_params)

    if @page_type.save
      redirect_to page_type_path
    else
      render 'new'
    end
  end

  def show
    @page_type = PageType.find(params[:id])
  end

  private

  def page_type_params
    params.require(:page_type).permit(:name)
  end
end
