class GamesController < ApplicationController
  respond_to :html, :json

  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
    @link = (@game.videolinks.first.url_html || "") unless @game.videolinks.first.blank?
    
    respond_with( @game )
  end
  
  def new
    @game = Game.new
    3.times { @game.videolinks.build }
  end
  
  def create
    @game = Game.new(params[:game])
    if @game.save
      flash[:notice] = "Successfully created game."
      redirect_to @game
    else
      render :action => 'new'
    end
  end
  
  def edit
    @game = Game.find(params[:id])
    3.times { @game.videolinks.build }
  end
  
  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:notice] = "Successfully updated game."
      redirect_to @game
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    flash[:notice] = "Successfully destroyed game."
    redirect_to games_url
  end
  
  
  def videos
    respond_with( @videos = Game.find(params[:id]).videolinks )
  end
  
  
end
