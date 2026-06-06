class EventsController < ApplicationController
  def index
    @events = Event.where("start_datetime >= ?", Time.current).order(:start_datetime)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :start_datetime,
      :end_datetime,
      :meeting_point,
      :location,
      :capacity
    )
  end
end