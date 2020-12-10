class UsersController < ApplicationController
	before_action :authenticate_supervisor, only: [:new, :index]	
	before_action :set_user, only: [:edit, :update, :destroy, :password, :admin_update, :user_update]
	before_action :verify_user, only: [:password]

  # What does this do?
  wrap_parameters :user, include: [:username, :password, :password_confirmation, :new_password, :current_password]

	def index
		@order_by = 'user_status_id'

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

		if params["/users"].present?
      if params["/users"][:userq].present?
        @query = params["/users"][:userq]
				@users = User.where("username LIKE :query
														 OR first_name LIKE :query
														 OR last_name LIKE :query", query: "%#{@query}%").order(@order_by).page(params[:page])
      else
        @users = User.order(@order_by).page(params[:page])
      end
    else
      @users = User.order(@order_by).page(params[:page])
    end

		# @users = User.order(@order_by)
		
  end

  def new
    @user = User.new
    @active = UserStatus.find_by_status('Active').id
  end

  def create
		@user = User.new(user_params)
		@active = UserStatus.first.id

    if @user.save
      redirect_to admin_path, notice: "#{@user.fullname} has been created."
    else
      render 'new'
    end
	end

	def edit
	end
	
	def update
		@user.update(user_params)
	end

	def admin_update
		if update
			redirect_to users_path, notice: "#{@user.fullname} has been updated."
		else
			render :edit
		end
	end

	def user_update
		if update
			redirect_to root_path, notice: 'Password updated!'
		else
			render :password
		end
	end

	def register_intern
		@user = User.new
	end

	def change_password
		@user = User.find(params[:id])
		if !@user.authenticate(params[:user][:current_password])
			flash[:error] = 'Password is incorrect.'
		elsif params[:user][:new_password] != params[:user][:password_confirmation]
			flash[:error] = 'New password and password confirmation do not match.'
		else
			params[:password] = params[:new_password]
			@user.update(:password)
		end
		render :password
	end

	# Worflow does not involve deleting users permanently. They must be offboarded and kept in the database for record-keeping.
  def destroy
    # redirect_to users_path, notice: "#{@user.username} has been deleted."
    # @user.destroy
	end

	def password
	end

	private

	def verify_user
		if current_user.id != @user.id
			redirect_to password_change_path(current_user), notice: 'Cannot change another user\'s password!'
		end
	end
	
	def set_user
		@user = User.find(params[:id])
	end

  def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :new_password, :current_password,
																 :user_level_id, :first_name, :last_name, :user_status_id, :email)
  end
end
