class Image
  include Mongoid::Document
  belongs_to :tweet
  field :url, type: String
end
