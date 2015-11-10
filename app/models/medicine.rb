class Medicine
  include Mongoid::Document
  has_many :prescription_items
  field :name, type: String
end
