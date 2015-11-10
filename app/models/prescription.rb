class Prescription
  include Mongoid::Document
  field :amount, type: Integer
  has_many :prescription_items, :autosave => true
  belongs_to :patient
end
