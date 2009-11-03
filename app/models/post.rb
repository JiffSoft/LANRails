class Post < ActiveRecord::Base
  belongs_to :topic, :counter_cache => true, :dependent => :delete_all
  belongs_to :user, :counter_cache => true

  after_create :update_topic_caches
  after_update :update_topic_caches
  after_destroy :update_topic_caches

  validate :topic_is_open

  def editable_by?(user)
    user && (user.id == user_id || user.admin? || user.moderator?)
  end

protected
  def update_topic_caches
    Topic.update_cached_fields(self)
  end

  def topic_is_open
    errors.add_to_base("Thread is locked") if topic && topic.locked? && topic.posts_count > 0
  end
end
