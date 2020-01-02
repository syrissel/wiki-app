class Page < ApplicationRecord
  belongs_to :approval_status
  belongs_to :user, optional: true
  belongs_to :category

  def self.search(search)
    if search
      Page.where("title LIKE '%#{search}%'")
    else
      nil
    end
  end
end
