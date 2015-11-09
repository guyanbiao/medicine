class Prescription
  include Mongoid::Document
  field :amount, type: Integer
  has_many :prescription_items
  belongs_to :patient
end
