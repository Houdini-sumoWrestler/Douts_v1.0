class Page < ApplicationRecord
  has_many :page_sections, -> { order(:position) }, dependent: :destroy

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  private

  def generate_slug
    self.slug = title.parameterize
  end
end