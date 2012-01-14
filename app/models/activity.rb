class Activity < ActiveRecord::Base
  include WriteControl

  belongs_to :author, :class_name => "User"
  has_many   :activity_registrations, :dependent => :destroy
  has_many   :users, :through => :activity_registrations

  has_slug 'title', :max_length  => 40,
                    :on_conflict => :append_id

  validates_presence_of :title, :body, :author

  def to_param
    slug
  end

  def approved_participants
    users.includes(:activity_registrations).
      where("activity_registrations.approved = true")
  end
end
