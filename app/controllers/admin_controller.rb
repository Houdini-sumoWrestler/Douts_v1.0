class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
  end

  private

  def require_admin
    user = User.find_by(id: session[:user_id])

    unless user&.admin?
      redirect_to root_path, alert: "You are not authorised to access that page."
    end
  end
end