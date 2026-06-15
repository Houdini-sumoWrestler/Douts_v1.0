class ApplicationController < ActionController::Base
  before_action :load_navigation

  helper_method :current_user

  private

  def load_navigation
    @main_nav_items = NavItem.visible.top_level.ordered.includes(:children)
  rescue ActiveRecord::StatementInvalid, PG::UndefinedTable, NameError
    @main_nav_items = []
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_admin
    unless current_user&.role == "admin"
      redirect_to root_path, alert: "You are not authorised to access that page."
    end
  end
end