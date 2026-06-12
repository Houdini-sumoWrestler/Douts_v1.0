class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      role: "member"
    )

    if @user.save
      @user.create_member(
        first_name: params[:first_name],
        last_name: params[:last_name],
        membership_class: params[:membership_class],
        code_of_conduct_accepted: params[:code_of_conduct_accepted] == "1",
        terms_accepted: params[:terms_accepted] == "1"
      )

      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
end