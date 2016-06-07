Rails.application.routes.draw do
  get '/', to: "devices#create"
  get '/show', to: "devices#show", as: :device
end
