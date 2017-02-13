class User < ActiveRecord::Base
  has_many :projects
  has_secure_password

  validates :username, presense: true, uniqueness: true
  validates :password, presense: true, length: { minimum: 8 }
end
