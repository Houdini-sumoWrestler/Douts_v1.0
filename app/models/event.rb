class Event < ApplicationRecord
  has_many :event_registrations, dependent: :destroy
  has_many :members, through: :event_registrations

  validates :title, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true

  validate :end_after_start

  private

  def end_after_start
    return if start_datetime.blank? || end_datetime.blank?

    if end_datetime <= start_datetime
      errors.add(:end_datetime, "must be after the start date/time")
    end
  end
end