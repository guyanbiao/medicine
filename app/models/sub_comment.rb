class SubComment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  belongs_to :comment
end
