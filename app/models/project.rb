class Project < ActiveRecord::Base
  belongs_to :user
  has_slug   :source    => :name,
             :on_blank  => false,   # Always update the slug
             :scope     => :user_id

  validates_presence_of :name

  attr_protected :core_project

end
