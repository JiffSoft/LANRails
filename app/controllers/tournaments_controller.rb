class TournamentsController < ApplicationController
  before_filter :require_login, :only => [:register]
  
  def index
  end

  def party
  end

  def view
  end

  def register
  end

end
