class FootPoint
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  validates_presence_of :user
  belongs_to :element, :polymorphic => true
  belongs_to :user
end
