class User < ActiveRecord::Base
  before_save :clean_website

  has_many :articles,               :foreign_key => :author_id
  has_many :activities,             :foreign_key => :author_id
  has_many :activity_registrations, :dependent => :destroy

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

  def self.create_from_hash(hash, overrides={})
    attributes = {
      name:    hash['info']['name'] || hash['info']['nickname'],
      email:   hash['info']['email'],
      github:  hash['info']['nickname'],
      uid:     hash['uid']
    }

    attributes[:website] = hash['info']['urls']['Blog'] if hash['info']['urls']
    
    create(attributes.merge(overrides))
  end

  def to_param
    github
  end

  private

  def clean_website
    # Remove http(s):// from the front of the website
    if website =~ /\Ahttp[s]?:\/\//i
      self.website = website.gsub(/\Ahttp[s]?:\/\//i, '')
    end

    # Remove any trailing slashes
    if website =~ /\/\z/
      self.website = website.gsub(/\/\z/, '')
    end
  end
end
