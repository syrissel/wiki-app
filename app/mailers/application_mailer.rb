class ApplicationMailer < ActionMailer::Base
  @settings = Setting.first
  default from: @settings.smtp_username
  layout 'mailer'
end
