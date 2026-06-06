class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(
      email: params[:email],
      password: params[:password],
      role: "member"
    )

    if @user.save
      @user.create_member(
        first_name: params[:first_name],
        last_name: params[:last_name]
      )

      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome to DOUTS!"
    else
      flash.now[:alert] = "Could not create account"
      render :new, status: :unprocessable_entity
    end
  end
end