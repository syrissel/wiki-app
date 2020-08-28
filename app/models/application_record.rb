class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.strip_tags(string)
    ActionController::Base.helpers.strip_tags(string)
  end
end
