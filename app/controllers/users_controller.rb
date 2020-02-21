class UsersController < ApplicationController
	before_action :authenticate_supervisor, only: [:new, :index]
	before_action :set_user, only: [:edit, :update, :destroy, :password, :admin_update, :user_update]
	before_action :verify_user, only: [:password]

  # What does this do?
  wrap_parameters :user, include: [:username, :password, :password_confirmation]

	def index
		@order_by = 'created_at'

		# if params[:s].present?
		# 	if @prev_order.present? && (@prev_order.eql? params[:s]) && (@prev_order.include? 'asc')
		# 		@order_by = params[:s] + ' desc'
		# 	else
		# 		@order_by = params[:s] + ' asc'
		# 	end
		# end

		# @prev_order = @order_by

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

		# if params[:s].present?
		# 	sort_param = params[:s]
		# 	if @prev_order.present? && (@prev_order.include? 'asc')
		# 		# @prev_order.slice! ' asc'
		# 		@order_by = sort_param + ' desc'
		# 	else
		# 		sort_param.slice! 'asc'
		# 		@order_by = sort_param + ' asc'
		# 	end
			
		# end

		# @prev_order = @order_by
		@users = User.order(@order_by)
		
		# case params[:s]
		# when 'username'
		# 	order_by = 'username'

		# end
  end

  def new
    @user = User.new
    @active = UserStatus.find_by_status('Active').id
  end

  def create
		@user = User.new(user_params)
		@active = UserStatus.first.id

    if @user.save
      redirect_to admin_path, notice: "#{@user.username} has been created."
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
			redirect_to admin_path, notice: "#{@user.username} has been updated."
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

	# Worflow does not invlove deleting users permanently. They must be offboarded and kept in the database for record-keeping.
  def destroy
    # redirect_to users_path, notice: "#{@user.username} has been deleted."
    # @user.destroy
	end

	def password
	end

	private

	def verify_user
		if current_user.id != @user.id
			redirect_to root_path, notice: 'Cannot change another user\'s password!'
		end
	end
	
	def set_user
		@user = User.find(params[:id])
	end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :user_level_id, :first_name, :last_name, :user_status_id)
  end
end
