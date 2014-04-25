class HomeController < ApplicationController
 layout :resolve_layout
  def index
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
  def search
    @query = params[:query]
    @camp = Camp.search(@query)
    @curriculums = Curriculum.search(@query)
    @instructor = Instructor.search(@query)
    @total_hits = @camp.size + @instructor.size + @curriculums.size
  end

  private

  def resolve_layout
    case action_name
    #When Home page displays index page. I have a default layout
    #specified. All other home pages inherit from 'home2' layout
    when "index"
      "home"
    else
      "home2"
    end
  end

end

