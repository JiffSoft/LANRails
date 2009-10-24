class RegistrationsController < ApplicationController
  before_filter :require_login, :only => [:new, :create]
  before_filter :require_moderator, :only => [:edit, :update, :destroy, :show]

  def index
    @regs = Registration.find_all_by_party_id(params[:party_id], :order => "created_on, paid DESC")
  end

  def show
    @reg = Registration.find(params[:id])
  end

  def new
    render :action => 'create'
  end

  def create
    # check to see if we have already registered
    if Registration.find_by_user_id_and_party_id(User.current, Party.current_party) then
      redirect_to :action => 'index'
    end
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
