class SponsorsController < ApplicationController
  before_filter :require_moderator, :only => [:create, :new, :edit, :update]
  before_filter :require_administrator, :only => [:destroy]

  def index
    @sponsors = Sponsor.find(:all)
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.valid? && @sponsor.save then
      # it's good!
      redirect_to sponsors_path
    end
  end

  def new
    @sponsor = Sponsor.new
    render :action => 'create'
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