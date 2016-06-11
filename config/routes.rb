Rails.application.routes.draw do
  get '/', to: "devices#create"
  get '/show', to: "devices#show", as: :device

  namespace :api, defaults: { format: :json }  do
    namespace :v1 do
      resources :signage, only: :index
    end
  end

  namespace :admin do
    resources :devices, only: [:index, :edit, :update, :destroy]
    resources :display, only: [:update]
  end
end
