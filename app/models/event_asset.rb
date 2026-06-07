class EventAsset < ApplicationRecord
  belongs_to :event
  belongs_to :asset

  validates :quantity_available, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validates :asset_id, uniqueness: {
    scope: :event_id,
    message: "has already been added to this event"
  }
end