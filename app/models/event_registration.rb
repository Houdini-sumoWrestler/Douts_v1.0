class EventRegistration < ApplicationRecord
  belongs_to :event
  belongs_to :member

  validates :status, presence: true
  validates :member_id, uniqueness: {
    scope: :event_id,
    message: "is already registered for this event"
  }
end