class Like < ActiveRecord::Base
  
  # Associations
  belongs_to :likeable, :polymorphic => true
  
  # Attributes
  attr_accessible :user_id, :likeable_id, :likeable_type, :amount
  
  # Validations
  validates_numericality_of :amount
  
  
  # Public methods
  def self.video?(user, video_id)
    return 0 if user.nil?
    like = Like.where( :user_id => user.id, :likeable_id => video_id, :likeable_type => "Videolink" )
    
    return like.first.amount if like.exists?
    return 0
  end
  
  
  def self.likesit(user_id, params)
    game_id = params[:game_id]
    videolink_id = params[:videolink_id]
    like_type = params[:like_type]
    
    return false if like_type.nil?

    if like_type == "videolink"
      liked = Like.where(:user_id => user_id, :likeable_id => videolink_id, :likeable_type => "Videolink").first unless videolink_id.nil?
    elsif like_type == "game"
      liked = Like.where(:user_id => user_id, :likeable_id => game_id, :likeable_type => "Game").first unless game_id.nil?
    end
    
    if liked.present?
      liked.amount = 1
      liked.save
      return true
    else  # not voted on before...create Like record
      if like_type == "videolink"
        Like.create(:user_id => user_id, :likeable_id => videolink_id, :likeable_type => "Videolink", :amount => 1) 
      elsif like_type == "game"
        Like.create(:user_id => user_id, :likeable_id => game_id, :likeable_type => "Game", :amount => 1) 
      end
      return true
    end

    return false
  end
  
end
