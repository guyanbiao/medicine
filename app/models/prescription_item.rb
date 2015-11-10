class PrescriptionItem
  include Mongoid::Document
  belongs_to :prescription
  belongs_to :medicine
  field :amount, type: Integer
end
