module WriteControl
  def editable_by?(user)
    persisted? && user && (user.admin? || user == author)
  end
end