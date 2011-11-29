class User < ActiveRecord::Base
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

  validates_format_of   :email,
                        :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_presence_of :name
  validates_presence_of :github

  attr_protected :admin

  def self.create_from_hash!(hash)
    attributes = {
      name:   hash['info']['name'],
      email:  hash['info']['email'],
      github: hash['info']['nickname'],
      uid:    hash['uid']
    }

    create(attributes)
  end
end
