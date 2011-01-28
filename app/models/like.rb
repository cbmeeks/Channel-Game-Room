class Like < ActiveRecord::Base
  
  # Associations
  belongs_to :likeable, :polymorphic => true
  
  # Attributes
  attr_accessible :user_id, :likeable_id, :likeable_type, :amount
  
  # Validations
  validates_numericality_of :amount
  
end
