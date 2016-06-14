class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, format: { with: /@/ }, uniqueness: true

  enum role: ["default", "admin"]
end
