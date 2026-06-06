class Member < ApplicationRecord
  belongs_to :user

  has_many :event_registrations, dependent: :destroy
  has_many :events, through: :event_registrations

  validates :first_name, presence: true
  validates :last_name, presence: true
end