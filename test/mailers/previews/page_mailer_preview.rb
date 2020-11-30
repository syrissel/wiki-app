# Preview all emails at http://localhost:3000/rails/mailers/page_mailer
class PageMailerPreview < ActionMailer::Preview
  def new_page_email
    page = Page.new(title: 'Mailer Test', content: "Here's some content.", category_id: 9, user_id: 1, approval_status_id: 1)

    PageMailer.with(page: page).new_page_email
  end

  def new_executive_email
    page = Page.new(title: 'Mailer Test', content: "Here's some content.", category_id: 9, user_id: 1, approval_status_id: 1, approved_by_id: 4)

    PageMailer.with(page: page).new_executive_email
  end
end
