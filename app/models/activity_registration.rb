class ActivityRegistration < ActiveRecord::Base
  before_create :set_approval

  belongs_to :user
  belongs_to :activity

  attr_protected :approved

  private

  def set_approval
    self.approved = !activity.participation_moderated?

    return true
  end
end
