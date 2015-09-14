class Meal
  include Mongoid::Document
  field :location, type: Array
  field :user_id, type: Integer
  field :meal_time, type: DateTime
  field :price, type: Float
  field :person_limit, type: Integer
  belongs_to :user
end
