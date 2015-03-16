class Tweet 
  include Mongoid::Document
  field :content, type: String, default: ""
  belongs_to :user
  has_many :comments
  validates_length_of :content, minimum: 1
end
