class Ability
  include CanCan::Ability
  
  def initialize(user)
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    # set authorizations for different user roles
    if user.role? :admin
      # they get to do it all
      can :manage, :all
      
    elsif user.role? :instructor
      # can see a list of all users
      can :index, User
      
      # they can read their own profile
      can :show, User do |u|  
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|  
        u.id == user.id
      end

      # they can read students in his camp
      can :read, Student do |this_student|  
        camp_students = user.camp.map{|c| c.students.map(&:id)}.flatten
        camp_students.include? this_student.id 
      end

      # they can read their own camps' data
      can :read, Camp do |this_camp|  
        my_camps = user.camp.map(&:id)
        my_camps.include? this_camp.id 
      end

    else
      # guests can read home page
      can :read, Home

      #guests can view upcoming camps
      can :index, Camp

      #guests can see camps details page, address and map.
      can :read, Camp
    end
  end
end