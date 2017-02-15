class Task < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :title
  validates_presence_of :content
end
