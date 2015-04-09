class Attachment
  include Mongoid::Document
  belongs_to :tweet
  field :image, type: String
  mount_uploader :image, ImageUploader
end
