class SystemsController < ApplicationController
  
  def index
    @systems = System.all
  end
  
  def show
    @system = System.find_by_slug(params[:system])
    
    if params[:filter].present?
      if params[:filter] == "0-9" then
        @games = @system.games.where("title LIKE '0%' OR title LIKE '1%' OR title LIKE '2%' OR title LIKE '3%' OR title LIKE '4%' OR title LIKE '5%' OR title LIKE '6%' OR title LIKE '7%' OR title LIKE '8%' OR title LIKE '9%'")
#        @games = @system.games.where("title LIKE ?", (0-9))
      else
        @games = @system.games.where("title LIKE ?", params[:filter].upcase + '%')
      end
    else
      @games = @system.games if @system.present?
    end
  end
  
end
