class Comment
  include Mongoid::Document
  field :content, type: String, default: ""
  belongs_to :tweet
end
