class User < ApplicationRecord
  has_one :member, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
