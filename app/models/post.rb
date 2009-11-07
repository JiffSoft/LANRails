class Post < ActiveRecord::Base
  belongs_to :topic, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates_presence_of :user_id
  validates_presence_of :topic_id

  after_create :update_topic_caches
  after_update :update_topic_caches
  after_destroy :update_topic_caches

  validate :topic_is_open

  def editable_by?(user)
    user && (user.id == user_id || user.admin? || user.moderator?)
  end

protected
  def update_topic_caches
    topic.update_cached_fields(self)
  end

  def topic_is_open
    errors.add_to_base("Thread is locked") if topic && topic.locked? && topic.posts_count > 0
  end
end
