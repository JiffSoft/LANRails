class TeamsController < ApplicationController
  before_filter :check_tournaments_enabled
  before_filter :require_login, :only => [:create, :new, :edit, :update, :destroy]
  before_filter :verify_user_not_in_team, :only => [:create, :new]
  uses_tiny_mce :options => {:theme => 'advanced'}, :only => [:create, :new, :edit, :update]

  def index
    @teams = Team.find_all_by_party_id(params[:party_id])
  end

  def create
    @team = Team.new(params[:team])
    @team.party_id = params[:party_id]
    #TODO need to add the team memberhsip as well
    if @team.save then
      @leader_membership = TeamMembership.new(:team_id => @team.id, :user_id => User.current.id, :leader => true, :active => true)
      if not @leader_membership.save then
        flash[:error] = "Your membership could not be completed due to an unknown error.  Please contact an administrator to fix this."
      end
      flash[:notice] = "Your team was created successfully!"
      redirect_to party_teams_path
    end
  end

  def new
    render :action => 'create'
  end

  def edit
  end

  def show
    @team = Team.find(params[:id])
  end

  def update
  end

  def destroy
    @team = Team.find(params[:id])
    TeamMembership.find_all_by_team_id(@team.id).each do |m|
      m.destroy
    end
    TournamentRegistration.find_all_by_team_id(@team.id).each do |r|
      r.destroy
    end
    @team.destroy
    flash[:notice] = "Your team has been successfully disbanded!"
    redirect_to party_teams_path
  end

private
  def check_tournaments_enabled
    redirect_to root_path if Settings[:enable_tournaments].match(/(true|t|yes|y|1)$/i) == nil
  end

  def verify_user_not_in_team
    redirect_to login_path if not User.current && User.current.loggedin?
    if Team.user_has_team?(params[:party_id], User.current) then
      flash[:error] = "You are already regstered on a team!"
      redirect_to party_teams_path
    end
  end
end
