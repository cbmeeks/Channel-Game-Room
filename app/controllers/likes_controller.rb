class LikesController < ApplicationController
  respond_to :json
  

  def vote
    results = {}    

    like_type = ["Videolink", "Game"].find { |e| e == params["like_type"] }.to_s.camelize
    id = params["id"] || 0
    
    if current_user
      results["status"] = "OK"
      results["liked"] = 0

      unless params["likesit"].nil?
        if params["likesit"].to_s == "true" 
          results["liked"] = current_user.likes( eval(like_type).where(:id => id).first )
        else
          results["liked"] = current_user.hates( eval(like_type).where(:id => id).first )
        end
      end
      
      results["like_type"] = like_type
    else
      results["status"] = "Error"
      results["message"] = "User not logged in"
      results["liked"] = nil
    end
    
    render :json => results.to_json
  end

  
end