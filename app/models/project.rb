class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of   :name, :slug
  validates_uniqueness_of :slug

  attr_protected :core_project
end
