class EventAssetsController < ApplicationController
  before_action :require_admin

  def create
    event = Event.find(params[:event_id])

    event_asset = EventAsset.new(
      event: event,
      asset_id: params[:asset_id],
      quantity_available: params[:quantity_available],
      price: params[:price]
    )

    if event_asset.save
      redirect_to event_path(event), notice: "Asset added to event."
    else
      redirect_to event_path(event), alert: event_asset.errors.full_messages.to_sentence
    end
  end

  def destroy
    event_asset = EventAsset.find(params[:id])
    event = event_asset.event

    event_asset.destroy

    redirect_to event_path(event), notice: "Asset removed from event."
  end

  private

  def require_admin
    user = User.find_by(id: session[:user_id])

    unless user&.admin?
      redirect_to root_path, alert: "You are not authorised to manage event assets."
    end
  end
end