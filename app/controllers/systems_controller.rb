class SystemsController < ApplicationController
  
  def index
    @systems = System.all
  end
  
  def show
    @system = System.find_by_slug(params[:system])
    @games = @system.games if @system.present?
  end
  
end
