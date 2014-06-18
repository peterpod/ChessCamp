class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  
  def index
    #list of registrations ordered with the by student scope
    @registrations = Registration.by_student.paginate(:page => params[:page]).per_page(10)
    @deposit_registrations = Registration.by_student.deposit_only.paginate(:page => params[:page]).per_page(10)
    @full_registrations = Registration.by_student.paid.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @registration = Registration.new
    @registration.camp_id = params[:camp_id] unless params[:camp_id].nil?
    @students = (Student.active.at_or_above_rating(@registration.camp.curriculum.min_rating).below_rating(@registration.camp.curriculum.max_rating).alphabetical.to_a) - (@registration.camp.students)  
  end

  def edit
  end

  def create
    @registration = Registration.new(registration_params)
    if @registration.save
      redirect_to @registration, notice: "You have successfully registered #{@registration.student.proper_name} for #{@registration.camp.curriculum.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @registration.update(registration_params)
      redirect_to @registration, notice: "This registration was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    @registration.destroy
    redirect_to registrations_url, notice: "This registration was removed from the system."
  end

  private
    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:camp_id, :student_id, :payment_status, :points_earned)
    end
end
