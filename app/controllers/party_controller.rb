class PartyController < ApplicationController
  before_filter :require_login, :only => [:register]
  
  def index
  end

  def view
  end

  def register
  end

end
