Rails.application.routes.draw do
  get '/', to: "devices#create"
  get '/show', to: "devices#show", as: :device

  get "/login",     to: "sessions#new"
  post "/login",    to: "sessions#create"

  namespace :api, defaults: { format: :json }  do
    namespace :v1 do
      resources :signage, only: [:index, :update]
      resources :slides, onyl: [:show, :create, :update]
    end
  end

  namespace :admin do
    get '/update_slides', to: "slides#refresh", as: :refresh_slides
    resources :slides do
      post '/confirm', to: 'slides#confirm'
    end
    resources :devices, only: [:index, :edit, :update, :destroy] do
      collection do
        post :reveal
      end
    end
    resources :display, only: [:update]
  end
end
