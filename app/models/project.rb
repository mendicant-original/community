class Project < ActiveRecord::Base
  belongs_to :user
  has_slug   :source    => :name,
             :on_blank  => false,   # Always update the slug
             :scope     => :user_id

  validates_presence_of :name

  attr_protected :core_project

  def can_edit?(user)
    if user && (user.admin? || self.user == user)
      true
    else
      false
    end
  end

end
