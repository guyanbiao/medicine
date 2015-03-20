class SubComment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  belongs_to :comment
  belongs_to :user
  validates_presence_of :user, :comment
  field :content, type: String
end
