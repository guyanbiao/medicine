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
  end
end
