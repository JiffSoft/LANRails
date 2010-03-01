class TeamMembershipsController < ApplicationController
  before_filter :require_login

  def new
    @team = Team.find(params[:team_id])
  end

  def create
    membership = TeamMembership.new()
    membership.user_id = User.current.id
    membership.team_id = params[:team_id]
    membership.leader = false
    membership.active = true
    membership.invite_code = nil
    if membership.save! then
      flash[:notice] = "You have joined this team successfully!"
      redirect_to party_team_path(:id => params[:team_id])
    else
      flash[:error] = "There was an error joining the team!"
      @team = Team.find(params[:team_id])
      render :action => 'new'
    end
  end

  def moderate
    @team = Team.find(params[:team_id])
    @party = Party.find(params[:party_id])
    if params[:xtdaction] == 'invite' then
      membership = TeamMembership.new()
      membership.user_id = params[:invitation][:user_id]
      membership.team_id = params[:team_id]
      membership.leader = false
      membership.invite_code = Digest::SHA1.hexdigest(rand(99999999999999).to_s.center(24, rand(9).to_s))
      membership.active = false
      if membership.save! then
        Postoffice.deliver_team_invitation_email(membership.user_id,User.current,@team,@party,membership.invite_code)
        flash[:notice] = "Your invitation was sent successfully!"
        redirect_to party_team_path(:id => params[:team_id])
      else
        flash[:error] = "There was an error sending your invitation!"
        redirect_to party_team_path(:id => params[:team_id])
      end
    end
  end

  def approve
    @invitation = TeamMembership.find_by_invite_code(params[:invite_code])
    if not @invitation then
      flash[:error] = "There was a problem finding your invitation."
      redirect_to root_path
    end
    if request.post? then
      if params[:invitation_accepted] == "no" then
        @invitation.destroy
        flash[:notice] = "You have turned down the invitation to join."
        redirect_to root_path
      else
        @invitation.active = true
        @invitation.invite_code = nil
        @invitation.save
        flash[:notice] = "You have successfully joined this team!"
        redirect_to party_team_path(:id => @invitation.team_id)
      end
    end
    @team = Team.find(params[:team_id])
  end

  def delete
  end

end
