class API < Grape::API
  prefix 'api'
  format :json
  get :abc do
    {name: "1"}
  end
  resource :spline do
    get do
      "ooo"
    end
  end
end
