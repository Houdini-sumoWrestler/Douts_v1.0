class UserDashboardController < ApplicationController
  before_action :require_login

  def show
    @user = User.find_by(id: session[:user_id])
    @member = @user.member
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "Please log in first."
    end
  end
end