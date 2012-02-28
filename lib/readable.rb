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
      total = count
      total = readable.count if respond_to?(:readable)

      total - read_by(user).count
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
