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
    results = {}
    number_of_videolinks = 0
    
    @game = Game.find(params[:id])
    
    if @game.present?
      like = Like.where(:user_id => current_user.id, :likeable_id => @game.id, :likeable_type => "Game").first if current_user
      results["Status"] = "OK"
      results["game_id"] = @game.id
      results["liked"] = (like.amount if like.present?) || 0
      results["videolinks"] = {}
      
      @game.videolinks.each_with_index do |vl, i|
        videolink = {}
        like = Like.where(:user_id => current_user.id, :likeable_id => vl.id, :likeable_type => "Videolink").first if current_user
        videolink["id"] = vl.id
        videolink["url_html"] = vl.url_html
        videolink["liked"] = (like.amount if like.present?) || 0
        results["videolinks"][i] = videolink
        number_of_videolinks += 1
      end
      results["number_of_videolinks"] = number_of_videolinks
    else
      results["Status"] = "Error"
      results["Message"] = "Can't find that game"
    end
    
    respond_with( @videos = results.to_json )
  end
  
  
end
