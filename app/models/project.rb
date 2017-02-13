class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :due_date

end
