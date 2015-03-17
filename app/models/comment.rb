class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  validates_presence_of :user
  field :content, type: String, default: ""
  belongs_to :tweet
  belongs_to :user
  has_many :sub_comments
  has_one :footpoint, as: :element
end
