class Forum < ActiveRecord::Base
  has_many :topics, :order => "#{Topic.table_name}.sticky DESC, #{Topic.table_name}.updated_at DESC"

  ACCESS_EVERYBODY = 0
  ACCESS_REGISTERED = 1
  ACCESS_MODERATORS = 2
  ACCESS_ADMINS = 3

  def has_access?(user)
    begin
      false if !user && access_required != Forum::ACCESS_EVERYBODY
      false if access_required != Forum::ACCESS_EVERYBODY && user.anonymous?
      false if access_required == Forum::ACCESS_MODERATORS && !user.moderator?
      false if access_required == Forum::ACCESS_ADMINS && !user.admin?
      true
    rescue
      false
    end
  end

  def post_count
    count = 0
    @threads = Topic.find_all_by_forum_id(id)
    for thread in @threads
      count += thread.posts_count
    end
    count
  end

  def topic_count
    Topic.count(:id, :conditions => {:forum_id => id})
  end
end
