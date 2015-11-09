class Symptom
  include Mongoid::Document
  has_and_belongs_to_many :patients
  field :name, type: String
end
