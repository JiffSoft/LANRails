class ThreadsController < ApplicationController
  before_filter :require_moderator, :only => [:destroy, :edit, :update]
  before_filter :require_login, :only => [:new, :create]

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
end
