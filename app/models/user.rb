class User < ActiveRecord::Base
  before_save :remove_http_from_website

  GITHUB_FORMAT = {
    :with        => /^(?!-)[a-z\d-]+/i,
    :message     => "can only contain alphanumeric characters and dashes.
                     Cannot start with a dash"
  }

  TWITTER_FORMAT = {
    :with        => /^\w+$/,
    :message     => "can only contain letters, numbers or underscores.",
    :allow_blank => true
  }

  validates :twitter, :length => { :maximum => 15 },
                                   :format  => TWITTER_FORMAT

  validates :github,  :length => { :maximum => 40 },
                                   :format  => GITHUB_FORMAT

  validates_presence_of   :name, :github
  validates_uniqueness_of :github

  attr_protected :admin

  def self.create_from_hash(hash)
    attributes = {
      name:    hash['info']['name'] || hash['info']['nickname'],
      email:   hash['info']['email'],
      github:  hash['info']['nickname'],
      website: hash['info']['urls']['Blog'],
      uid:     hash['uid']
    }

    create(attributes)
  end

  def to_param
    github
  end

  private

  def remove_http_from_website
    if website =~ /\Ahttp[s]?:\/\//i
      self.website = website.gsub(/\Ahttp[s]?:\/\//i, '')
    end
  end
end
