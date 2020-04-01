class NotificationsController < ApplicationController

  def new
  end

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      flash[:notice] = 'Notification has been sent to user.'
    end

  end

  def destroy
  end

  private

  def notification_params
    params.fetch(:notification, {}).permit(:recipient_id, :actor_id, :message, :comment_id)
  end
  
end
