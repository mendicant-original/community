module Readable
  extend ActiveSupport::Concern

  included do
    has_many :readings, :as => :readable

    scope :read_by, ->(user) {
      joins(:readings).where("readings.user_id = ?", user.id)
    }
  end

  module ClassMethods
    def unread_count_by(user)
      if respond_to?(:readable)
        total = readable.count
        read  = read_by(user).
                  where("#{readable.table_name}.id IN (?)", readable).count
      else
        total = count
        read  = read_by(user).count
      end

      total - read
    end

    def read_all(user)
      read   = read_by(user)
      if read.empty?
        unread = all
      else
        unread = where("#{table_name}.id NOT IN (?)", read)
      end

      unread.each {|readable| readable.mark_as_read(user) }
    end
  end

  def mark_as_read(user)
    reading = Reading.where(user_id: user, readable_type: self.class, readable_id: id)
    reading.first || reading.create
  end

  def read_by?(user)
    Reading.has_read?(user, self)
  end
end
