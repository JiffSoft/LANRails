class Post < ActiveRecord::Base
  belongs_to :thread
  belongs_to :user

  def editable_by?(user)
    user && (user.id == user_id || user.admin? || user.moderator?)
  end
end
