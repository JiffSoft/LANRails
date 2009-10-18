class PartyController < ApplicationController
  before_filter :require_administrator, :only => [:create, :new, :edit, :update, :destroy]
  uses_tiny_mce :options => {:theme => 'advanced'}, :only => [:create, :new]

  def index
    if not User.current && User.current.admin? then
      if Party.current_party then
        redirect_to show_party_path, :party_id => Party.current_party.id
      else
        redirect_to root_path
      end
    end
  end

  def create
    @party = Party.new(params[:party])
    @party.start_time = params[:start_date]
    @party.end_time = params[:end_date]
    if @party.save then
      redirect_to party_index_path
    end
  end

  def new
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
