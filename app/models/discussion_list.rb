class DiscussionList < ActiveRecord::Base
  belongs_to :activity

  validates_uniqueness_of :name
  validates_presence_of :name

  def email_address
    "c+#{name}@mendicantuniversity.org"
  end

  def list_manager
    Newman::MailingList.new(name, NEWMAN_DB)
  end

  def subscribe(email)
    list_manager.subscribe(email) unless list_manager.subscriber?(email)
  end

  def unsubscribe(email)
    list_manager.unsubscribe(email) if list_manager.subscriber?(email)
  end
end
