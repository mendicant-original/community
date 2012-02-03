class ActivityRegistration < ActiveRecord::Base
  before_create :update_approval
  after_save    :update_discussion_list
  after_destroy :update_discussion_list

  belongs_to :user
  belongs_to :activity

  validates_uniqueness_of :user_id, :scope => :activity_id

  private

  def update_approval
    if approved.nil?
      self.approved = !activity.participation_moderated?
    end

    return true
  end

  def update_discussion_list
    discussion_list = activity.discussion_list

    return unless discussion_list

    if destroyed? || !approved?
      discussion_list.unsubscribe(user.email)
    else
      discussion_list.subscribe(user.email)
    end
  end
end
