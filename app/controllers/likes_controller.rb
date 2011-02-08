class LikesController < ApplicationController
  
  before_filter :get_ids
  
  respond_to :json
  

  def update
    results = {}
    
    if current_user
      results["status"] = "OK"
      results["liked"] = Like.likesit(current_user.id, params)      
    else
      results["status"] = "Error"
      results["message"] = "User not logged in"
      results["liked"] = nil
    end
    
    render :json => results.to_json
  end
  

  private
  
  def get_ids
    @vid_id = params[:videolink_id]
  end
  
end