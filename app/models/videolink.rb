class Videolink < ActiveRecord::Base

  include AutoHtml

  auto_html_for :url do
    html_escape
    image
    youtube(:width => 640, :height => 505)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end


  # Associations
  belongs_to :game
  has_many :likes, :as => :likeable
  
  # Attributes
  attr_accessible :game_id, :provider, :video_id, :url, :url_html
  
  # Callbacks
  before_save :get_video_id
  
  # Validations
  
  private 
  def get_video_id
    regex = /http:\/\/(www.)?youtube\.com\/watch\?v=([A-Za-z0-9._%-]*)(\&\S+)?/
    
    self.url.gsub(regex) do
      self.video_id = $2.to_s
    end
    
  end
  
  
end
