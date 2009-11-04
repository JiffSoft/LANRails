class TopicsController < ApplicationController
  before_filter :check_forums_enabled
  before_filter :require_moderator, :only => [:destroy, :edit, :update]
  before_filter :require_login, :only => [:new, :create]
  uses_tiny_mce :only => [:new, :create, :edit]

  def index
    redirect_to :controller => 'forum'
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
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
