Rails.application.routes.draw do
  get '/', to: "sessions#create"
  get '/show', to: "sessions#show", as: :session
end
