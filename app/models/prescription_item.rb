class PrescriptionItem
  include Mongoid::Document
  belongs_to :prescription
  has_one :medicine
  field :amount, type: Integer
end
