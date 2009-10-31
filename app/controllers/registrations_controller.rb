class RegistrationsController < ApplicationController
  before_filter :require_login, :only => [:new, :create]
  before_filter :require_moderator, :only => [:edit, :update, :destroy, :show]

  def index
    @regs = Registration.find_all_by_party_id(params[:party_id], :order => "created_at, paid DESC")
  end

  def show
    @reg = Registration.find(params[:id])
  end

  def new
    @target_party = Party.find(params[:party_id])
    render :action => 'create'
  end

  def create
    # check to see if we have already registered
    if Registration.find_by_user_id_and_party_id(User.current, params[:party_id]) then
      redirect_to :action => 'index'
    else
      @target_party = Party.find(params[:party_id])
      @reg = Registration.new(params[:registration])
      @reg.user_id = User.current.id
      @reg.save
      if @target_party.price > 0 then
        render :action => 'prepay'
      else
        render :action => 'thank_you'
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
