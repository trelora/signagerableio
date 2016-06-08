Rails.application.routes.draw do
  get '/', to: "devices#create"
  get '/show', to: "devices#show", as: :device

  namespace :admin do
    resources :devices, only: [:index]
  end
end
