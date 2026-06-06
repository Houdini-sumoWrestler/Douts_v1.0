class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email]
    password = params[:password]

    # Placeholder login logic for now
    if email.present? && password.present?
      session[:user_email] = email
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Email and password are required"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_email)
    redirect_to login_path, notice: "Logged out"
  end
end