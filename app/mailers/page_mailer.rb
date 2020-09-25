class PageMailer < ApplicationMailer
  def new_page_email
    @page = params[:page]

    # mail(to: ENV["admin_email"], subject: "New wiki submitted by #{@page.user.fullname}")
    mail(to: User.only_supervisors.where("email IS NOT NULL").where(user_status_id: 1).where.not(id: @page.user_id).pluck(:email), subject: "New wiki submitted by #{@page.user.fullname}")
  end

  def new_executive_email
    @page = params[:page]

    mail(to: User.executives.where("email IS NOT NULL").where(user_status_id: 1).where.not(id: @page.user_id).pluck(:email), subject: "New wiki submitted by #{@page.user.fullname}")
  end
end
