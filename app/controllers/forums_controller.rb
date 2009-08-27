class ForumsController < ApplicationController
  def index
    @forums = Forum.find(:all)
  end

  def show
    @threads = Thread.find_by_forum_id(params[:id])
  end
end
