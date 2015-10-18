class Meal
  include Mongoid::Document
  mount_uploader :meal_picture, MealPictureUploader

  field :location, type: Array
  field :user_id, type: Integer
  field :meal_time, type: DateTime
  field :price, type: Float
  field :seats_limit, type: Integer, default: 0
  field :seats_occupied, type: Integer, default: 0
  field :title, type: String
  belongs_to :user
  index({ location: "2d" })

  def seats_left
    seats_limit - seats_occupied
  end
end
