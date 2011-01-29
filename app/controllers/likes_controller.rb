class LikesController < ApplicationController
  
  before_filter :get_ids
  
  respond_to :json
  
  def videolink
    results = {}
    
    # check to see if the user has liked this videolink before
    if current_user
      liked = Like.video?(current_user, @vid_id)

      results["status"] = "OK"      
      results["liked"] = liked
    else
      results["status"] = "Error"
      results["message"] = "User not logged in"
    end

    respond_with( results.to_json ) 
  end
  
  
  def update
    results = {}
    
    if current_user
      results["status"] = "OK"  
    else
      results["status"] = "Error"
      results["message"] = "User not logged in"
    end
    
    respond_with( results.to_json )
  end
  

  private
  
  def get_ids
    @vid_id = params[:videolink_id]
  end
  
end