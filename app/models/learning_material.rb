class LearningMaterial < ActiveRecord::Base
  has_slug   :source    => :name

  validates_presence_of :name

  def self.fuzzy_find(id)
    find(Integer(id))
  rescue
    find_by_slug(id)
  end
end
