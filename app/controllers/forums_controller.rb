class ForumsController < ApplicationController
  before_filter :check_forums_enabled
  before_filter :require_administrator, :only => [:create, :edit, :update, :destroy]
  uses_tiny_mce :only => [:new, :create, :edit]

  def index
    @forums = Forum.find(:all)
  end

  def show
    @threads = Thread.find_by_forum_id(params[:id])
  end

  def new
    render :action => 'create'
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.valid? and @forum.save then
      redirect_to forums_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def check_forums_enabled
    redirect_to root_path if Settings[:enable_forums].match(/(true|t|yes|y|1)$/i) == nil
  end
end
