class NavItem < ApplicationRecord
  belongs_to :parent, class_name: "NavItem", optional: true
  has_many :children, class_name: "NavItem", foreign_key: "parent_id", dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  scope :visible, -> { where(visible: true) }
  scope :top_level, -> { where(parent_id: nil) }
  scope :ordered, -> { order(:position, :title) }
end