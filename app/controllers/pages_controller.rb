class PagesController < ApplicationController
  before_action :authenticate_supervisor, only: [:review, :admin, :wiki_management] # review_wiki
	before_action :authenticate_user, except: [:index, :show, :review_wiki] # show
	
	# This will prevent people from viewing the page when it's published but also being reviewed.
  before_action :check_published, only: [:show]
  before_action :can_edit, only: [:edit]
  
  

  def index
    # Check if there are any users in database for first time registration.
    @users = User.all
    @user = User.new if User.all.count == 0
    if params["/pages"].present? && params["/pages"][:query].present? || params["/pages"].present? && params["/pages"][:category_search].present?
      @query = params["/pages"][:query]
      @filters = []


      full_sql = "page_publish_status_id = :publish AND sanitized_content LIKE :query
                OR page_publish_status_id = :publish AND title LIKE :query
                OR page_publish_status_id = :publish AND username LIKE :query
                OR page_publish_status_id = :publish AND categories.name LIKE :query
                OR page_publish_status_id = :publish AND users.first_name LIKE :query
                OR page_publish_status_id = :publish AND users.last_name LIKE :query"
      sql = ''

      # If filter is checked on the search form.
      if params["/pages"][:title].present? && params["/pages"][:title] == "1"
        sql += "page_publish_status_id = :publish AND title LIKE :query OR "
        @filters.push 'Title'
      end

      if params["/pages"][:content].present? && params["/pages"][:content] == "1"
        sql += "page_publish_status_id = :publish AND sanitized_content LIKE :query OR "
        @filters.push 'Content'
      end

      if params["/pages"][:category].present? && params["/pages"][:category] == "1"
        sql += "page_publish_status_id = :publish AND categories.name LIKE :query OR "
        @filters.push 'Category name'
      end

      if params["/pages"][:user].present? && params["/pages"][:user] == "1"
        sql += "page_publish_status_id = :publish AND username LIKE :query OR page_publish_status_id = :publish AND users.first_name LIKE :query OR page_publish_status_id = :publish AND users.last_name LIKE :query OR "
        @filters.push 'Author'
      end

      # Remove last 'OR' at the end of the sql string. If no filters applied, search all filters.
      sql = sql.length != 0 ? sql.sub(/(.*)\bor\b/i, '\1') : full_sql

      if params["/pages"][:category_search].present?
        @category = Category.find(params["/pages"][:category_search])
        @filters.push @category.name

        if params["/pages"][:query] == ''
          redirect_to category_path(@category)
        else
          @pages = @category.pages.joins(:user).joins(:category).where(sql, publish: PUBLISHED, query: "%#{@query}%").pinned_categories.page params[:page]
        end
      else
        @pages = Page.joins(:user).joins(:category).where(sql, publish: PUBLISHED, query: "%#{@query}%" ).global.page params[:page]
      end
    else

      @pages = Page.where(page_publish_status_id: PUBLISHED).global.page params[:page]
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

    respond_to do |format|
      format.html
      format.js
    end

  end

  def new
    @page = Page.new
		@confirm = ['Submitting for supervisor approval. Continue?', 'Publishing page. Continue?']
    @videos = video_search
    @images = image_search
    @pdfs = pdf_search

    @categories = Category.order(:id).where('category_id IS NULL')
    # @users = User.order(:name).page params[:page]
    
    # respond_to do |format|
    #   format.html { render 'new' } 
    #   format.js
    # end
  end

  def show
    @page = Page.find(params[:id])
    @publish_statuses = PagePublishStatus.all
    if current_user.nil?
      session[:page] = @page.id
      authenticate_user
    end
  end

  def edit
    @images = image_search
		@page = Page.find(params[:id])
    @videos = video_search
    @pdfs = pdf_search

    respond_to do |format|
      format.html { render :edit }
      format.js
    end
  end

  def update
    @page = Page.find(params[:id])
    @page.page_publish_status_id = PUBLISHED if params[:page][:approval_status_id].to_i == EXECUTIVE_VALUE

    # If checkbox is unchecked, set value to nil for sorting reasons.
    if params[:page][:global_pinned].present? && params[:page][:global_pinned] == "1" && @page.global_pinned.nil?
      params[:page][:pinned_by_id] = current_user.id
    elsif params[:page][:global_pinned].present? && params[:page][:global_pinned] == "0"
      params[:page][:global_pinned] = nil
    end

    if params[:page][:category_pinned].present? && params[:page][:category_pinned] == "1" && @page.category_pinned.nil?
      params[:page][:category_pinned_by_id] = current_user.id
    elsif params[:page][:category_pinned].present? && params[:page][:category_pinned] == "0"
      params[:page][:category_pinned] = nil
    end

    #params[:page][:global_pinned] = (params[:page][:global_pinned] == "0") ? nil : params[:page][:global_pinned]
    # params[:page][:category_pinned] = (params[:page][:category_pinned] == "0") ? nil : params[:page][:category_pinned]

    if @page.update(page_params)

      # If supervisor approved, send executives a notification.
      if params[:page][:approval_status_id].to_i == SUPERVISOR_VALUE
        PageMailer.with(page: @page, settings: Setting.first).new_executive_email.deliver_later
        (User.executives.uniq - [current_user]).each do |s|
          Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "A wiki has been approved by #{current_user.fullname}", page_id: @page.id)
        end
      # If an executive rejects a wiki, notify supervisors
      elsif params[:page][:approval_status_id].to_i == REJECTED && current_user.user_level_id == EXECUTIVE_VALUE
        (User.supervisors.uniq - [current_user]).each do |s|
          Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "A wiki has been rejected by #{current_user.fullname}", page_id: @page.id)
        end
        # Send author notification.
        Notification.create(recipient_id: @page.user_id, actor_id: current_user.id, message: "Your wiki has been rejected by #{current_user.fullname}", page_id: @page.id)
      elsif params[:page][:approval_status_id].to_i == EXECUTIVE_VALUE
        Notification.create(is_published: 'Y', recipient_id: @page.user_id, actor_id: current_user.id, message: "Your wiki, \"#{@page.title}\" has been published.", page_id: @page.id)
      elsif params[:page][:approval_status_id].to_i == REJECTED
        Notification.create(recipient_id: @page.user_id, actor_id: current_user.id, message: "Your wiki has been rejected by #{current_user.fullname}", page_id: @page.id)
      # else
      #   (User.supervisors.uniq - [current_user]).each do |s|
      #     Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "#{@page.title} has a new edit by #{current_user.fullname}", page_id: @page.id)
      #   end
      end

      respond_to do |format|
        format.html { redirect_to wiki_management_path, notice: "#{@page.title} has been updated." }
        format.js
      end

    end
  end

  # Instantiates new Page object with permitted values. Duplicate content is stored
  # in the table until it is approved. When it is approved, the update will be called
  # and the review columns will be set to nil perserving space in the DB.
  def create
    params[:page][:last_edited_at] = Time.now
		@page = Page.new(page_params)
    
    if (@page.save)
      PageMailer.with(page: @page, settings: Setting.first).new_page_email.deliver_later

      @page.sanitized_content = ActionController::Base.helpers.strip_tags(@page.content)
			
			if @page.user.user_level_id == EXECUTIVE_VALUE
				@page.approval_status_id = EXECUTIVE_VALUE
				@page.page_publish_status_id = PUBLISHED
			end

			@page.save
		
			(User.supervisors.uniq - [current_user]).each do |s|
				Notification.create(recipient_id: s.id, actor_id: current_user.id, message: "New wiki submitted by #{current_user.username}", page_id: @page.id)
			end
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

  def unpublished
    @pages = Page.where(page_publish_status_id: UNPUBLISHED).where(approval_status_id: EXECUTIVE_VALUE).page params[:page]
    if params["/unpublished"].present? && params["/unpublished"][:q].present?
      @search = params["/unpublished"][:q].strip
      @pages = @pages.joins(:user).joins(:category).where("title LIKE :search 
                                                             OR username LIKE :search 
                                                             OR name LIKE :search
                                                             OR first_name LIKE :search
                                                             OR last_name LIKE :search", search: "%#{@search}%")
    end
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

    if current_user.nil?
      session[:review_wiki] = @page.id
      authenticate_supervisor
    else
      authenticate_supervisor
      @statuses = (current_user.user_level_id == SUPERVISOR_VALUE) ? ApprovalStatus.where.not(id: [ EXECUTIVE_VALUE ]) : ApprovalStatus.all
    end
	end

  def admin

	end
	
	def bell_ring
		render partial: 'layouts/notification_bell'
	end

  def wiki_management
    @pages = Page.all
  end

  private 

  def set_page

  end

  def page_params
		params.require(:page).permit(:title, :content, :approval_status_id, :user_id, :category_id,
																 :title_review, :content_review, :category_review, :last_user_edit, 
                                 :pinned, :search, :image, :description, :sanitized_content, :page,
                                 :page_publish_status_id, :comments, :category_pinned, :global_pinned,
                                 :last_edited_at, :pinned_by_id, :category_pinned_by_id, :approved_by_id)
  end

  def can_edit
    @page = Page.find(params[:id])
    redirect_to root_path, alert: 'Unauthorized' unless (current_user == @page.user && @page.approval_status_id == REJECTED && @page.page_publish_status_id == UNPUBLISHED) || current_user.user_level_id > INTERN_VALUE
  end
	
	def check_published
		@page = Page.find(params[:id])

		if @page.page_publish_status_id == UNPUBLISHED && current_user.user_level_id < SUPERVISOR_VALUE
			redirect_to root_path, notice: 'Page has not been published yet.'
		end
	end
end
