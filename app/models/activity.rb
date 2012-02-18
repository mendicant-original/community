class Activity < ActiveRecord::Base
  include WriteControl
  include Readable

  belongs_to :author, :class_name => "User"
  has_many   :activity_registrations, :dependent => :destroy
  has_many   :users, :through => :activity_registrations
  has_one    :discussion_list

  accepts_nested_attributes_for :activity_registrations,
    :allow_destroy => true,
    :reject_if     => lambda { |attributes| attributes['user_id'].blank? }

  has_slug 'title', :max_length  => 20,
                    :on_conflict => :append_id

  validates_presence_of   :title, :body, :author

  scope :active,   where(:archived => false)
  scope :archived, where(:archived => true)

  def self.readable
    active
  end

  def to_param
    slug
  end

  def approved_participants
    users.includes(:activity_registrations).
      where("activity_registrations.approved = true").order("users.name")
  end

  def create_discussion_list(list_name)
    if discussion_list.nil?
      DiscussionList.create(:name => list_name, :activity_id => self.id)
    else
      discussion_list
    end
  end

end
