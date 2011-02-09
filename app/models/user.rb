class User < ActiveRecord::Base
  
  # Associations
  has_many :likes, :dependent => :destroy  
  
  
  # Methods
  
  def likes_the(obj)
    like = Like.find_or_initialize_by_likeable_type_and_likeable_id_and_user_id(obj.class.name, obj.id, self.id)
    like.amount = 1
    like.save
   end
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end
end
