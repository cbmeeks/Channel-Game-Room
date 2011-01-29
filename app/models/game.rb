class Game < ActiveRecord::Base

  # Associations
  belongs_to :system
  has_many :videolinks, :dependent => :destroy
  accepts_nested_attributes_for :videolinks, :reject_if => lambda { |a| a[:url].blank? }

  # Attributes
  attr_accessible :system_id, :title, :description, :videolinks_attributes
  
  # Callbacks
  before_save :update_permalink
  
  # Validations
  validates_presence_of :system_id, :message => "game system required"
  validates_presence_of :title
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  
  def update_permalink
    self.permalink = "#{self.title.to_slug}-#{self.system.slug}"
  end
  
end