class TournamentRegistrationsController < ApplicationController
  before_filter :check_tournaments_enabled, :require_login, :check_is_team_leader

  def new
    @tournament = Tournament.find(params[:tournament_id])
    render :action => 'create'
  end

  def create
    @team_reg = TournamentRegistration.new(:team_id => User.current.own_team(params[:party_id]).id, :tournament_id => params[:tournament_id])
    if @team_reg.save then
      flash[:notice] = "You have been registered for this tournament!"
      redirect_to party_tournament_path(:id => params[:tournament_id])
    else
      flash[:error] = "An unknown error occured registering your team for the tournament!"
      @tournament = Tournament.find(params[:tournament_id])
    end
  end

  def delete
  end

  def destroy
  end

private
  def check_tournaments_enabled
    redirect_to root_path if Settings[:enable_tournaments].match(/(true|t|yes|y|1)$/i) == nil
  end

  def check_is_team_leader
    if not User.current.has_team_leader?(params[:party_id]) then
      flash[:error] = "You must be the leader of a team to register for tournaments!"
      redirect_to party_tournaments_path
    end
  end
end
