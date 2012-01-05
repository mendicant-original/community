class Page < ActiveRecord::Base
  has_slug :title

  def to_param
    slug
  end
end
