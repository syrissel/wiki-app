# Preview all emails at http://localhost:3000/rails/mailers/page_mailer
class PageMailerPreview < ActionMailer::Preview
  def new_page_email
    page = Page.new(title: 'Mailer Test', content: "Here's some content.", category_id: 9, user_id: 1)

    PageMailer.with(page: page).new_page_email
  end
end
