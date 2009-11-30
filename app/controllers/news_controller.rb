class NewsController < ApplicationController
  before_filter :require_moderator, :only => [:new, :update, :destroy, :edit, :create]
  uses_tiny_mce :options => {:theme => 'advanced'},
    :only => [:new, :edit, :create, :update]
    
  def index
    @news = News.find(:all, :limit => Settings[:frontpage_news_limit],
      :order => 'created_at DESC');
    if request.format.rss? then
      response.headers['Content-Type'] = 'application/rss+xml'
      render :action => 'feed', :layout => false
    end
  end

  def show
    @news = News.find(params[:id])
    if not @news
      redirect_to :controller => 'news', :action => 'index'
    end
  end

  def new
    @news = News.new
    render :action => 'create'
  end

  def edit
    @news = News.find(params[:id])
    render :action => 'update'
  end

  def update
    
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    flash[:notice] = "You have deleted the news article #{@news.title}"
    redirect_to news_path
  end

  def create
    # actually post the article
    @news = News.new(params[:news])
    @news.user_id = User.current.id
    if @news.valid? && @news.save then
      # it's good!
      redirect_to news_index_path
    end
  end

  def feed
  end
end
