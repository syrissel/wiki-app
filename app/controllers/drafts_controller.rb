class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update, :destroy]

  # GET /drafts
  # GET /drafts.json
  def index
    @drafts = Draft.all
  end

  # GET /drafts/1
  # GET /drafts/1.json
  def show
  end

  # GET /drafts/new
  def new
    @draft = Draft.new
    @page = Page.find(params[:id])
  end

  # GET /drafts/1/edit
  def edit
    @page = Page.find(@draft.page_id)
  end

  # POST /drafts
  # POST /drafts.json
  def create
    @draft = Draft.new(draft_params)
    @page = Page.find(params[:page][:id])

    respond_to do |format|
      if @draft.save
        format.html { redirect_to @draft, notice: 'Draft was successfully created.' }
        format.json { render :show, status: :created, location: @draft }
      else
        format.html { render :new }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drafts/1
  # PATCH/PUT /drafts/1.json
  def update
    @page = Page.find(params[:draft][:page_id])
    
    if @draft.update(draft_params)
      if params[:draft][:approval_status_id].to_i == EXECUTIVE_VALUE
        @page.content = @draft.content

        # For search functionality.
        @page.sanitized_content = ActionController::Base.helpers.strip_tags(@draft.content)
        @page.title = @draft.title
        @page.category_id = @draft.category_id
        @page.last_user_edit = User.find_by_username(@draft.user_id)
        @page.update(title: @page.title, content: @page.content, category_id: @page.category_id)
        @draft.destroy
        redirect_to @page, notice: "#{@page.title} has been saved!"
      else
          respond_to do |format|
          format.html { redirect_to @draft, notice: 'Draft was successfully updated.' }
          format.json { render :show, status: :ok, location: @draft }
        end
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drafts/1
  # DELETE /drafts/1.json
  def destroy
    @draft.destroy
    respond_to do |format|
      format.html { redirect_to drafts_url, notice: 'Draft was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_draft
      @draft = Draft.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def draft_params
      params.require(:draft).permit(:title, :content, :category_id, :approval_status_id, :page_id, :user_id)
    end
end
