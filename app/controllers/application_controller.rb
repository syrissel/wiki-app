class ApplicationController < ActionController::Base

  before_action :set_layout_variables

  def set_layout_variables
    @makes = Make.all
  end

end
