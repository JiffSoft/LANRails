class NewsController < ApplicationController
  before_filter :require_moderator, :only => [:write]
  uses_tiny_mce :options => {:theme => 'advanced'},
    :only => [:write]
    
  def index
  end

  def view
  end

  def write
  end
end
