class Article < ActiveRecord::Base
  include WriteControl

  belongs_to :author, :class_name => "User"

  has_slug 'title', :max_length  => 40,
                    :on_conflict => :append_id

  validates_presence_of :title, :body, :author
  with_options :allow_blank => true do |opt|
    opt.validates_length_of :title, :minimum => 3
  end

  scope :newest, order("sticky desc, created_at desc")

  def to_param
    slug
  end
end
