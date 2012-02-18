class Reading < ActiveRecord::Base
  belongs_to :readable, :polymorphic => true
  belongs_to :user

  def self.has_read?(user, article)
    return true unless user

    Reading.exists?(
      :user_id => user.id,
      :readable_id => article.id,
      :readable_type => article.class.name
    )
  end
end
