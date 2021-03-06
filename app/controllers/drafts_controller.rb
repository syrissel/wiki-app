class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :authenticate_supervisor, only: [:index, :show]
  before_action :can_edit, only: [:edit]

  # GET /drafts
  # GET /drafts.json
  def index
    @drafts = Draft.supervisor_approved_first().order(approval_status_id: :asc).order(updated_at: :desc).page params[:page]

    if params["/drafts"].present? && params["/drafts"][:q].present?
      @search = params["/drafts"][:q].strip
      @drafts = @drafts.joins(:user).joins(:category).where("title LIKE :search 
                                                             OR username LIKE :search 
                                                             OR name LIKE :search
                                                             OR first_name LIKE :search
                                                             OR last_name LIKE :search", search: "%#{@search}%")
    end
  end

  # GET /drafts/1
  # GET /drafts/1.json
  def show
    @page = Page.find(@draft.page_id)
    @statuses = (current_user.user_level_id == SUPERVISOR_VALUE) ? ApprovalStatus.where.not(id: [ EXECUTIVE_VALUE ]) : ApprovalStatus.all

    # All of this code below is to basically add new lines after each element to account for the Diffy Gem functionality
    delimiters = ['</h1>', '</h2>', '</h3>', '</h4>', '</h5>', '</p>',  '</li>']
    @page_text = @page.content.split(Regexp.union(delimiters))
    @draft_text = @draft.content.split(Regexp.union(delimiters))
    @page_string = ""
    @draft_string = ""

    @page_text.each do |text|
      if text.include? '<p'
        text += "\n</p>"
      elsif text.include? '<h1'
        text += "\n</h1>"
      elsif text.include? '<h2'
        text+= "\n</h2>"
      elsif text.include? '<h3'
        text += "\n</h3>"
      elsif text.include? '<h4'
        text += "\n</h4>"
      elsif text.include? '<li'
        text += "\n</li>"
      end
      @page_string += ActionController::Base.helpers.strip_tags(text.strip)
    end

    @draft_text.each do |text|
      if text.include? '<p'
        text += "\n</p>"
      elsif text.include? '<h1'
        text += "\n</h1>"
      elsif text.include? '<h2'
        text+= "\n</h2>"
      elsif text.include? '<h3'
        text += "\n</h3>"
      elsif text.include? '<h4'
        text += "\n</h4>"
      elsif text.include? '<li'
        text += "\n</li>"
      end
      @draft_string += ActionController::Base.helpers.strip_tags(text.strip)
    end
  end

  # GET /drafts/new
  def new
    @draft = Draft.new
    @page = Page.find(params[:id])
    @images = image_search
    @videos = video_search

    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /drafts/1/edit
  def edit
    @page = Page.find(@draft.page_id)
    @images = image_search
    @videos = video_search
  end

  # POST /drafts
  # POST /drafts.json
  def create
    @draft = Draft.new(draft_params)
    @page = Page.find(params[:page][:id])

    respond_to do |format|
      if @draft.save
        (User.supervisors.uniq - [current_user]).each do |s|
          Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "#{current_user.fullname} created a draft for \"#{@page.title}\"", draft_id: @draft.id)
        end

        format.html { redirect_to root_path, notice: 'Draft was successfully created.' }
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

      # Draft is approved by CEO. Draft is merged with wiki then deleted.
      if params[:draft][:approval_status_id].to_i == EXECUTIVE_VALUE
        @page.content = @draft.content

        # For search functionality.
        @page.sanitized_content = ActionController::Base.helpers.strip_tags(@draft.content)
        @page.title = @draft.title
        @page.category_id = @draft.category_id
        @page.last_user_edit = User.find(@draft.user_id).username
        @page.last_edited_at = Time.now
        @page.update(title: @page.title, content: @page.content, category_id: @page.category_id)
        @draft.destroy
        redirect_to @page, notice: "Draft has been merged with #{@page.title}!"

      # Any other update to the draft.
      else
        action = 'updated'

        case @draft.approval_status_id
        when SUPERVISOR_VALUE
          action = 'approved'
        when REJECTED
          action = 'rejected'
        end

        if @draft.approval_status_id == REJECTED
          Notification.create(recipient_id: @draft.user_id, actor_id: current_user.id, message: "#{current_user.fullname} rejected your draft \"#{@draft.title}\"", draft_id: @draft.id)
        else
          (User.supervisors.uniq - [ current_user ]).each do |s|
            Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "#{current_user.fullname} #{action} a draft \"#{@draft.title}\"", draft_id: @draft.id)
          end
        end

        if current_user.user_level_id > INTERN_VALUE
          respond_to do |format|
            format.html { redirect_to @draft, notice: 'Draft was successfully updated.' }
            format.json { render :show, status: :ok, location: @draft }
          end
        else
          redirect_to root_path, notice: 'Draft was successfully updated.'
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
      params.require(:draft).permit(:title, :content, :category_id, :approval_status_id, :page_id, :user_id, :description, :comments)
    end

    def can_edit
      redirect_to root_path, alert: 'Unauthorized' unless current_user == @draft.user || current_user.user_level_id > INTERN_VALUE
    end
end
