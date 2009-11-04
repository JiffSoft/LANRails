class TournamentsController < ApplicationController
  before_filter :check_tournaments_enabled

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
  def check_tournaments_enabled
    redirect_to root_path if Settings[:enable_tournaments].match(/(true|t|yes|y|1)$/i) == nil
  end
end
