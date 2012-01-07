class Article < ActiveRecord::Base
  belongs_to :author, :class_name => "User"

  has_slug 'title', :max_length => 40

  validates_presence_of :title, :body, :author
  with_options :allow_blank => true do |opt|
    opt.validates_length_of :title, :minimum => 3
  end

  def editable_by?(user)
    persisted? && user && (user.admin? || user == author)
  end

  def to_param
    slug
  end
end
