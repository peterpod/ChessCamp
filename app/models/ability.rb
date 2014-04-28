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

      # they can add locations
      can :create, Location
      
      # they can edit locations
      can :update, Location

       # they can add camps
      can :create, Camp
      
      # they can edit camps
      can :update, Camp      

       # they can add students
      can :create, Student
      
      # they can edit students
      can :update, Student

       # they can add families
      can :create, Family
      
      # they can edit families
      can :update, Family

       # they can read students in his camp
      can :read, Student do |this_student|  
        camp_students = user.camps.map{|c| c.students.map(&:id)}.flatten
        camp_students.include? this_student.id 
      end

      # they can read their own camps' data
      can :read, Camp do |this_camp|  
        my_camps = user.camps.map(&:id)
        my_camps.include? this_camp.id 
      end
           
      # they can read students in these camps
      can :read, Student do |this_student|  
        instructor_students = user.camps.map{|c| c.students.map(&:id)}.flatten
        instructor_students.include? this_student.id 
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