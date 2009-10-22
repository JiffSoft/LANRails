class ForumsController < ApplicationController
  before_filter :require_administrator, :only => [:create, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
