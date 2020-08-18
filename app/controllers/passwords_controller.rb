class PasswordsController < ApplicationController
  #include PasswordForm
  def new
    @password_form = PasswordForm.new(current_user)
  end

  def create
    @password_form = PasswordForm.new(current_user)

    if @password_form.submit(params[:password_form])
      redirect_to root_path, notice: 'Password changed.'
    else
      render :new
    end
  end
end