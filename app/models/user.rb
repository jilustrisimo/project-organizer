class User < ActiveRecord::Base
  has_many :projects
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }

  def delete_everything
    projects.each { |project| project.tasks.delete_all }
    projects.delete_all
  end
end
