class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  
  def index
    @deposit_registrations = Registration.deposit_only.paginate(:page => params[:page]).per_page(10)
    @full_registrations = Registration.paid.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @registration = Registration.new
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration, notice: "#{@registration} was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: "#{@registration} was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: "#{@registration} was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end
end
