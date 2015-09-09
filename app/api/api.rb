class API < Grape::API
  prefix 'api'
  format :json
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
      {name: "meal"}
    end
  end
end
