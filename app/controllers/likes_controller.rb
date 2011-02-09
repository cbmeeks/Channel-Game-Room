class LikesController < ApplicationController
  respond_to :json
  

  def it
    results = {}    

    like_type = ["Videolink", "Game"].find { |e| e == params["like_type"] }.to_s.camelize
    id = params["id"] || 0
    
    if current_user
      results["status"] = "OK"      
      results["liked"] = current_user.likes_the( eval(like_type).where(:id => id).first )
    else
      results["status"] = "Error"
      results["message"] = "User not logged in"
      results["liked"] = nil
    end
    
    render :json => results.to_json
  end

  
end