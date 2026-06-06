class User < ApplicationRecord
  has_secure_password

  has_one :member, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  ROLES = %w[member admin]

  validates :role, presence: true, inclusion: { in: ROLES }

  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end
end