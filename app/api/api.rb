class API < Grape::API
  prefix 'api'
  format :json

  helpers do
    def current_user
      User.last
    end
  end

  get :abc do
    {name: "1"}
  end
  resource :meals do
    desc "get all meals"
    get do
      Meal.where(:meal_picture.ne => nil).map {|x|
        {
          title: "东北乱炖",
          picture: x.meal_picture.url,
          lat: x.location[0],
          lng: x.location[1],
          seats_left: x.seats_left,
          seats_limit: x.seats_limit,
          price: x.price
        }
      }
    end
    post :create_location do
      meal = current_user.meals.new(location: [Float(params[:lat]), Float(params[:lng])])
      if meal.save
        {id: meal.id.to_s}
      else
        {description: meal.errors.full_messages.join(", ")}
      end
    end

    params do
      requires :meal, type: Hash do
        requires :meal_time, type: String
        requires :price, type: String
        requires :seats_limit, type: Integer
      end
    end
    post :add_more_info do
      meal = Meal.find params[:id]
    end

    post :upload do
      meal = Meal.find params[:id]
      meal.meal_picture = params[:file]
      meal.update_attributes params[:meal]
      meal.save
    end
  end
end
