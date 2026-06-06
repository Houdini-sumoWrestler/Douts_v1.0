class EventRegistrationsController < ApplicationController
  before_action :require_login

  def create
    event = Event.find(params[:event_id])
    user = User.find(session[:user_id])
    member = user.member

    unless member
      redirect_to event_path(event), alert: "You need a member profile before registering."
      return
    end

    registration = EventRegistration.new(
      event: event,
      member: member,
      status: "registered"
    )

    if registration.save
      redirect_to event_path(event), notice: "You are registered for this event."
    else
      redirect_to event_path(event), alert: registration.errors.full_messages.to_sentence
    end
  end

  def destroy
    registration = EventRegistration.find(params[:id])
    event = registration.event
    user = User.find(session[:user_id])

    if registration.member == user.member
      registration.destroy
      redirect_to event_path(event), notice: "Registration cancelled."
    else
      redirect_to event_path(event), alert: "You cannot cancel this registration."
    end
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "Please log in first."
    end
  end
end