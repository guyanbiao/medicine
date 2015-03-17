Rails.application.routes.draw do
  devise_for :users, path: "accounts",
  controllers: {
    sessions: "accounts/sessions",
    registrations: "accounts/registrations",
    confirmations: "accounts/confirmations",
    passwords: "accounts/passwords",
    unlocks: "accounts/unlocks"
  }
  root 'home#index'
  resources :tweets do
    resources :comments
    member do
      post :vote
    end
  end
  #comments
  post "comments/:commend_id/sub_comments" => "comments#create_sub"

  #user
  get "users/username" => "users"

  #infohub
  get "messages" => "infohub"
  post "messages" => "infohub#create_message"
  get "messages/:session_id" => "infohub#show_message"
  get "replies" => "infohub"
  get "activities" => "infohub"
end
