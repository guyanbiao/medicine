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
  post 'home/import'

end
