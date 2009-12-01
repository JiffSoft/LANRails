class PostObserver < ActiveRecord::Observer
  def after_create(post)
    @users = Array.new
    topic = Topic.find(post.topic_id)
    posts = Post.find_all_by_topic_id(post.topic_id)
    posts.each do |p|
      if p.user_id != User.current.id then
        @users.push(p.user_id)
      end
    end
    @users.uniq.each do |u|
      Postoffice.deliver_new_post_email(u, topic, post)
    end
  end
end
