class PostsController < ApplicationController
  before_filter :check_forums_enabled
  before_filter :require_login, :only => [:new, :create]
  before_filter :check_post_edit, :only => [:edit, :update]
  before_filter :check_post_del, :only => [:destroy]
  uses_tiny_mce :only => [:new, :create, :edit]

  def index
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
   def check_post_edit

   end

   def check_post_del

   end

  def check_forums_enabled
    redirect_to root_path if Settings[:enable_forums].match(/(true|t|yes|y|1)$/i) == nil
  end
end
