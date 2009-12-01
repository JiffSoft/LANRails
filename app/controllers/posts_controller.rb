class PostsController < ApplicationController
  before_filter :check_forums_enabled, :bring_up_forum_topic_vars
  before_filter :require_login, :only => [:new, :create]
  before_filter :check_post_edit, :only => [:edit, :update]
  before_filter :check_post_del, :only => [:destroy]
  uses_tiny_mce :only => [:new, :create, :edit]

  def index
    @posts = Post.find_all_by_topic_id params[:topic_id]
  end

  def create
    @post = Post.new(:body => params[:post_body], :user_id => User.current.id, :topic_id => params[:topic_id])
    if @post.valid? and @post.save then
      # check to see if we shoudl lock or sticky
      if User.current.moderator? then
        if params[:lock][:value1] == 1 then
          @topic.locked = true
        end
        if params[:sticky][:value1] == 1 then
          @topic.sticky = true
        end
        @topic.save
      end
      redirect_to forum_topic_posts_path
    end
  end

  def new
    render :action => 'create'
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def bring_up_forum_topic_vars
    @forum = Forum.find(params[:forum_id])
    @topic = Topic.find(params[:topic_id])
  end

   def check_post_edit

   end

   def check_post_del

   end

  def check_forums_enabled
    redirect_to root_path if Settings[:enable_forums].match(/(true|t|yes|y|1)$/i) == nil
  end
end
