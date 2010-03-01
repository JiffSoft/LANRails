class TeamMembershipsController < ApplicationController
  def new
  end

  def create
  end

  def moderate
    @team = Team.find(params[:team_id])
    @party = Party.find(params[:party_id])
    case params[:action]
    when 'invite'
      membership = TeamMembership.new(params[:membership])
      membership.team_id = params[:team_id]
      membership.leader = false
      membership.invite_code = Digest::SHA1.hexdigest(rand(99999999999999).to_s.center(24, rand(9).to_s))
      membership.active = false
      if membership.save then
        PostOffice.deliver_team_invitation_email(membership.user_id,User.current,@team,@party,membership.invite_code)
        flash[:notice] = "Your invitation was sent successfully!"
        redirect_to party_team_path(:id => params[:team_id])
      else
        flash[:error] = "There was an error sending your invitation!"
        redirect_to party_team_path(:id => params[:team_id])
      end
    end
  end

  def approve
  end

  def delete
  end

end
