class Admin::BaseController < ApplicationController

  before_action :require_admin

  def require_admin
    redirect_to root_path unless current_admin?
  end
end
