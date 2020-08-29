class PageMailer < ApplicationMailer
  def new_page_email
    @page = params[:page]

    mail(to: ENV["admin_email"], subject: "New wiki submitted by #{@page.user.fullname}")
  end
end
