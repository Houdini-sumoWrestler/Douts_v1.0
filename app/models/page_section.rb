class PageSection < ApplicationRecord
  belongs_to :page

  validates :section_key, presence: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  scope :visible, -> { where(visible: true) }
end