class ActivityRegistration < ActiveRecord::Base
  before_create :set_approval

  belongs_to :user
  belongs_to :activity

  validates_uniqueness_of :user_id, :scope => :activity_id

  private

  def set_approval
    if approved.nil?
      self.approved = !activity.participation_moderated?
    end

    return true
  end
end
