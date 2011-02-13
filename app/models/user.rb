class User < ActiveRecord::Base
  
  # Associations
  has_many :likes, :dependent => :destroy  
  
  
  # Methods
  
  def toggle_vote(obj)
    like = get_like(obj)
    like.amount = (like.amount == 1  ? -1 : 1) || 1
    like.save
    like.amount
  end
  
  def likes(obj)
    like = get_like(obj)
    like.amount = 1
    like.save
    like.amount
  end 

  def hates(obj)
    like = get_like(obj)
    like.amount = -1
    like.save
    like.amount
  end 
   
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end
  
  private
  
  def get_like(obj)
    Like.find_or_initialize_by_likeable_type_and_likeable_id_and_user_id(obj.class.name, obj.id, self.id)
  end
  
end
