class GamesController < ApplicationController
  respond_to :html, :json

  def index
    @games = Game.all
  end
  
  def show
    @video_id = (params[:video_id].to_i - 1) || 0
    @video_id = 0 if @video_id < 0
      
    @game = Game.find(params[:id])
    @link = (@game.videolinks[@video_id].url_html || "") unless @game.videolinks[@video_id].nil?
    
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
    @game = Game.find(params[:id])
    respond_with( @videos = @game.videolinks )
  end
  
  
end
