class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource

 def index
    @all_students = Student.alphabetical.paginate(:page => params[:page]).per_page(20)
    @active_students = Student.active.alphabetical.paginate(:page => params[:page]).per_page(20)
    @inactive_students = Student.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
    @upcoming_student_camps = @student.camps.upcoming.chronological
    @past_student_camps = @student.camps.past.chronological
 end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: "#{@student.proper_name} was added to the system"
    else
      render action: 'new'
    end
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: "#{@student.proper_name} was revised in the system"
    else
      render action: 'edit'
    end
  end

  def destroy
    @student.destroy
    redirect_to students_url, notice: "#{@student.proper_name} was removed from the system."
  end

  private
    def convert_start_and_end_dates
      params[:student][:date_of_birth] = convert_to_date(params[:student][:date_of_birth]) unless params[:student][:date_of_birth].blank?
    end

    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      convert_start_and_end_dates
      params.require(:student).permit(:first_name, :last_name, :family_id, :date_of_birth, :rating, :active)
    end
end
