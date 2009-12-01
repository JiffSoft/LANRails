class TopicsController < ApplicationController
  before_filter :check_forums_enabled
  #before_filter :require_moderator, :only => [:destroy, :edit, :update]
  before_filter :require_login, :only => [:new, :create]
  uses_tiny_mce :only => [:new, :create]

  def index
    @forum = Forum.find(params[:forum_id])
    if request.format.rss? then
      @topics = Topic.find_all_by_forum_id(params[:forum_id], :limit => 50, :order => "updated_at DESC")
      response.headers['Content-Type'] = 'application/rss+xml'
      render :action => 'feed', :layout => false
    end
    @topics = Topic.find_all_by_forum_id(params[:forum_id])
  end

  def create
    @topic = Topic.new(:title => params[:topic][:title], :forum_id => params[:forum_id], :user_id => User.current.id)
    if User.current.moderator? then
      @topic.sticky = params[:topic][:sticky]
    else
      @topic.sticky = 0
    end
    if @topic.valid? and @topic.save then
      @post = Post.new(:body => params[:post_body], :topic_id => @topic.id, :user_id => User.current.id)
      if @post.valid? and @post.save then
        redirect_to forum_topic_posts_path(:forum_id => params[:forum_id], :topic_id => @topic.id)
      end
    end
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.find_all_by_forum_id(params[:forum_id])
  end

  def new
    @forum = Forum.find(params[:forum_id])
    render :action => 'create'
  end

  def feed
  end

private
  def check_forums_enabled
    redirect_to root_path if Settings[:enable_forums].match(/(true|t|yes|y|1)$/i) == nil
  end
end
