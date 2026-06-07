class Asset < ApplicationRecord
  has_many :event_assets, dependent: :destroy
  has_many :events, through: :event_assets

  validates :name, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end