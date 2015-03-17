class FootPoint
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  validates_presence_of :user
  belongs_to :element, :polymorphic => true
  belongs_to :user

  def real_member
    self.element_type.constantize.find(self.element_id)
  end
end
