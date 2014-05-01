class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    @upcoming_camps = current_user.instructor.camps.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    @registrations = current_user.instructor.camps.registrations.by_student.deposit_only.paginate(:page => params[:page]).per_page(10)
    @user = current_user
  end

  def show
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
