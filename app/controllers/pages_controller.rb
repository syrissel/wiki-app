class PagesController < ApplicationController
  before_action :authenticate_supervisor, only: [:review, :admin, :review_wiki]
	before_action :authenticate_user, except: [:index]
	
	# This will prevent people from viewing the page when it's published but also being reviewed.
	before_action :check_pending, only: [:edit]
	before_action :check_published, only: [:show]
  
  

  def index
    if params[:query].present?
      @query = params[:query]
      @pages = Page.joins(:user).where("page_publish_status_id = :publish AND sanitized_content LIKE :query
                                        OR page_publish_status_id = :publish AND title LIKE :query
                                        OR page_publish_status_id = :publish AND username LIKE :query
																				OR page_publish_status_id = :publish AND description LIKE :query", 
                                        publish: PUBLISHED, query: "%#{@query}%" ).order("updated_at desc").limit(10).page params[:page]

      @videos = Video.where("name LIKE :query", query: "%#{@query}%").order(:created_at).limit(36)
    else
      @pages = Page.where(page_publish_status_id: PUBLISHED).order("updated_at desc").page params[:page]
    end
		
		if params[:clear].present?
			#@user_notifications = Notification.where('recipient_id = ?', current_user.id)
			@notifications.each do |n|
				n.destroy
			end
		end

		if params[:read].present?
			#@user_notifications = Notification.where('recipient_id = ?', current_user.id)
			@notifications.each do |n|
				n.update(read_at: Time.now)
			end
    end

  end

  def new
    @page = Page.new
		@confirm = ['Submitting for supervisor approval. Continue?', 'Publishing page. Continue?']
    @videos = Video.order(created_at: :desc).page params[:page]

    if params["/pages/new"].present? && params["/pages/new"][:imageq].present?
      @query = params["/pages/new"][:imageq]
      @images = Image.where("name LIKE :query", query: "%#{@query}%").where('path IS NOT NULL').where(video_path: nil).order(created_at: :desc).page params[:page]
    else
      @images = Image.where('path IS NOT NULL').where(video_path: nil).order(created_at: :desc).page params[:page]
    end
    @categories = Category.order(:id).where('category_id IS NULL')
    # @users = User.order(:name).page params[:page]
    
    # respond_to do |format|
    #   format.html { render 'new' } 
    #   format.js
    # end
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
		@page = Page.find(params[:id])
    @videos = Video.order(:created_at).limit(36).page params[:page]
    @images = Image.where('path IS NOT NULL').order(:created_at).limit(36).page params[:page]
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
			
			if @page.user.user_level_id == EXECUTIVE_VALUE
				@page.approval_status_id = EXECUTIVE_VALUE
				@page.page_publish_status_id = PUBLISHED
			end

			@page.save
		
			(User.supervisors.uniq - [current_user]).each do |s|
				Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "New wiki submitted by #{current_user.username}", page_id: @page.id)
			end
			Notification.create(recipient_id: EXECUTIVE_VALUE, actor_id: current_user.id, message: "")
      flash[:notice] = 'Wiki has been submitted for review!'
      redirect_to pages_path
    else
      render 'new'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    redirect_to review_path, notice: "#{@page.title} deleted."
		@page.destroy!
	rescue ActiveRecord::RecordNotDestroyed => error
		puts "errors that prevented destruction: #{error.record.errors}"
  end

  # Review this
	def review
		@order_by = 'updated_at desc'

		if params[:s].present?
			filter_params = params[:s]
			if params[:s].include? 'desc'
				
				filter_params.slice! '_desc'
				@order_by = filter_params + ' desc'
			else
				filter_params.slice! '_asc'
				@order_by = filter_params + ' asc'
			end
    end
    
    if params['/review'].present? && params['/review'][:reviewq].present?
      query = params['/review'][:reviewq]
      @pending_pages = Page.where("title LIKE :query
                                   OR last_user_edit LIKE :query", query: "%#{query}%")
                            .order(@order_by)
                            .page(params[:page])
                            .per(20)
    else
      @pending_pages = Page.where.not(approval_status_id: EXECUTIVE_VALUE).order(@order_by).page(params[:page]).per(20)
    end
	end
	
	def review_wiki
		@page = Page.find(params[:id])
		@page_forum = PageForum.find_by_page_id(@page.id)
		#@comments = Comment.where(page_forum_id: @page_forum.id)
	end

  def admin

	end
	
	def bell_ring
		render partial: 'layouts/notification_bell'
	end

  def wiki_management
    @pages = Page.all
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

  def set_page

  end

  def page_params
		params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id,
																 :title_review, :content_review, :category_review, :last_user_edit, 
																 :pinned, :search, :image, :description, :sanitized_content, :page, :page_publish_status_id)
		#params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id)
  end

  def check_pending
		@page = Page.find(params[:id])
		@user = User.find_by_username(@page.last_user_edit)

		# If the current user is either the Executive Director or a Supervisor, render the edit page.
		# If the current user is not in that category, if the page's approval status is not 'pending', render the edit page.
		# Finally, if the page is pending and the current user is not the user who last edited the wiki, they will be redirected the home page.
		if (current_user.user_level_id == EXECUTIVE_VALUE || current_user.user_level_id == SUPERVISOR_VALUE) || (@page.approval_status_id != PENDING) || (current_user == @user)
			render :edit
		else
			redirect_to root_path, notice: "Cannot edit #{@page.title}. It is currently being reviewed."
    end
	end
	
	def check_published
		@page = Page.find(params[:id])

		if @page.page_publish_status_id == UNPUBLISHED
			redirect_to root_path, notice: 'Page has not been published yet.'
		end
	end
end
