class TournamentsController < ApplicationController
  before_filter :check_tournaments_enabled
  before_filter :require_administrator, :only => [:new, :create, :edit, :update, :destroy]
  uses_tiny_mce :options => {:theme => 'advanced'}, :only => [:create, :new]

  def index
    @party = Party.find(params[:party_id])
    @tournaments = Tournament.find_all_by_party_id(params[:party_id])
    @teams = Team.find_all_by_party_id(params[:party_id])
  end

  def create
    @tournament = Tournament.new(params[:tournament])
    @tournament.party_id = params[:party_id]
    if @tournament.save then
      redirect_to party_tournaments_path
    end
  end

  def new
    render :action => 'create'
  end

  def edit
  end

  def show
    @party = Party.find(params[:party_id])
    @tournament = Tournament.find(params[:id])
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
