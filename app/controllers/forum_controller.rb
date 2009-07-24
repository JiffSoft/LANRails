class ForumController < ApplicationController
  before_filter :require_login, :only => [:reply, :postnew]
  
  def index
  end

  def threads
  end

  def view
  end

  def reply
  end

  def postnew
  end

end
