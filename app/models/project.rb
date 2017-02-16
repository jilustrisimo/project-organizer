class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :due_date

  def completed_tasks?
    tasks.where(completed: true).count == tasks.count && tasks.count > 0
  end

  def check_if_project_completed
    update(completed: true) if completed_tasks?
  end
end
