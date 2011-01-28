class User < ActiveRecord::Base
  
  # Associations
  has_many :likes
  
  
  
  # Methods
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
    end
  end
end
