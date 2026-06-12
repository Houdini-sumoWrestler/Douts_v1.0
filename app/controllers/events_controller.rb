class EventsController < ApplicationController
  def index
    @events = Event.order(:start_datetime)

    @calendar_date =
      if params[:month].present?
        Date.parse(params[:month])
      else
        Date.today
      end

    @start_date = @calendar_date.beginning_of_month.beginning_of_week(:monday)
    @end_date = @calendar_date.end_of_month.end_of_week(:monday)

    @calendar_events = Event
      .where(start_datetime: @start_date.beginning_of_day..@end_date.end_of_day)
      .order(:start_datetime)
      .group_by { |event| event.start_datetime.to_date }
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