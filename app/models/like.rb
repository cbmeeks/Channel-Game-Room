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
  
end
