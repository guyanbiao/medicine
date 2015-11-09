class Patient
  include Mongoid::Document
  include Mongoid::Enum
  field :name, type: String
  field :age, type: Integer
  enum :gender, [:male, :female]
  has_and_belongs_to_many :symptoms
  has_many :prescriptions
end
