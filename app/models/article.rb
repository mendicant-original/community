class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  validates_presence_of :title, :url, :body, :author
  with_options :allow_blank => true do |opt|
    opt.validates_length_of :title, :minimum => 3
    opt.validates_format_of :url,   :with    => URI.regexp
  end

  def editable_by?(user)
    persisted? && user && (user.admin? || user == author)
  end
end
