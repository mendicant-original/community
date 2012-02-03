class DiscussionList < ActiveRecord::Base
  belongs_to :activity

  validates_uniqueness_of :name
  validates_presence_of :name

  def email_address
    "c+#{name}@mendicantuniversity.org"
  end
end
