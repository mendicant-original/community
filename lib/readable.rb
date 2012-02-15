module Readable
  def mark_as_readable
    has_many :readings, :as => :readable
    scope :read_by, lambda{|user| joins(:readings).where("readings.user_id = ?", user.id) }

    extend ClassMethods
    include InstanceMethods
  end

  module ClassMethods
    def unread_count_by(user)
      count - read_by(user).count
    end
  end

  module InstanceMethods
    def mark_read_by!(user)
      Reading.find_or_create_by_user_id_and_readable_id_and_readable_type(user.id, id, self.class.name)
    end

    def read_by?(user)
      Reading.has_read?(user, self)
    end
  end
end

ActiveRecord::Base.extend(Readable)
