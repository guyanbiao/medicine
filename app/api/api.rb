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
      5.times.map { 
        {
          title: "meal",
          lat: "187.1",
          lng: "189.2",
          price: "19",
          left_seats: 4,
        }
      }
    end
    post :create_location do
      meal = current_user.meals.create(location: [params[:lat], params[:lng]])
      {id: meal.id.to_s}
    end

    params do
      requires :meal, type: Hash do
        requires :meal_time, type: String
        requires :price, type: String
        requires :person_limit, type: Integer
      end
    end
    post :add_more_info do
      meal = Meal.find params[:id]
      meal.update_attributes params[:meal]
    end

    post :upload do
      puts params
    end
  end
end
