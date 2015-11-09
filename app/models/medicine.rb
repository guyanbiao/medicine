class Medicine
  include Mongoid::Document
  belongs_to :prescription_item
  field :name, type: String
end
