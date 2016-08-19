Rails.application.routes.draw do
  get '/', to: "devices#create"
  get '/show', to: "devices#show", as: :device

  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"

  namespace :api, defaults: { format: :json }  do
    namespace :v1 do
      resources :signage, only: :index
    end
  end

  namespace :admin do
    get '/update_slides', to: "slides#update", as: :refresh_slides
    resources :devices, only: [:index, :edit, :update, :destroy] do
      collection do
        post :reveal
      end
    end
    resources :display, only: [:update]
  end
end
