class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @upcoming_camps = current_user.instructor.camps.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    #@registrations = current_user.instructor.camps.students.paginate(:page => params[:page]).per_page(10)
    @deposit_registrations = Registration.by_student.deposit_only.paginate(:page => params[:page]).per_page(10)
    @full_registrations = Registration.by_student.paid.paginate(:page => params[:page]).per_page(10)
    @instructor_assignments = Instructor.all.paginate(:page => params[:page]).per_page(10)
    @user = current_user
    @upcoming_registrations = 0
    @upcoming_camps.each do |camp|
      @upcoming_registrations += camp.registrations.size
    end
    if (current_user != nil) && (current_user.role == "instructor") 
      @instructor_camps = current_user.instructor.camps.upcoming.chronological.paginate(:page => params[:page]).per_page(5)
    end
  end

  def show
  end

  def registered_students
  end

  def search
    @query = params[:query]
    @instructors = Instructor.search(@query)
    @students = Student.search(@query)
    @total_hits = @instructors.size + @students.size
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.instructor.proper_name} was revised in the system"
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed #{@user.instructor.proper_name} from ChessCamp."
    redirect_to users_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user && current_user.role?(:admin)
        params.require(:user).permit(:username, :instructor_id, :password, :password_confirmation, :role, :active)  
      else
        params.require(:user).permit(:username, :instructor_id, :password, :password_confirmation, :active)
      end
    end
end
