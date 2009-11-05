class RegistrationsController < ApplicationController
  before_filter :require_login, :only => [:new, :create]
  before_filter :require_moderator, :only => [:edit, :update, :destroy, :show]

  def index
    @party = Party.find(params[:party_id])
    @regs = Registration.find_all_by_party_id(params[:party_id], :order => "created_at, paid DESC")
  end

  def show
    @party = Party.find(params[:party_id])
    @reg = Registration.find(params[:id])
  end

  def new
    @party = Party.find(params[:party_id])
    @target_party = Party.find(params[:party_id])
  end

  def create
    # check to see if we have already registered
    if Registration.find_by_user_id_and_party_id(User.current, params[:party_id]) then
      redirect_to :action => 'index'
    else
      @target_party = Party.find(params[:party_id])
      @reg = Registration.new(params[:registration])
      @reg.party_id = params[:party_id]
      @reg.user_id = User.current.id
      if @reg.save then
        Postoffice.deliver_party_registration_email(User.current,@target_party,@reg)
        if @target_party.price > 0 then
          render :action => 'prepay'
        else
          render :action => 'thank_you'
        end
      else
        render :action => 'new'
      end
    end
  end

  def prepay
  end

  def thank_you
  end

  def edit
    @reg = Registration.find(params[:id])
  end

  def update
    
  end

  def destroy
    Registrations.delete(params[:id])
    redirect_to party_registrations_path, :party_id => params[:party_id]
  end
end
