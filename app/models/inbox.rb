class Inbox < Struct.new(:activities, :articles)

  def initialize(user)
    self.articles = self.activities = 0

    return if user.nil?

    self.articles   = Article.unread_count_by(user)
    self.activities = Activity.unread_count_by(user)
  end

end
