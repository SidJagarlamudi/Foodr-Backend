Rails.application.routes.draw do
  resources :users
  resources :businesses, only: [:index, :show]
  resources :favorites
  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#create'
      get '/reauth', to: 'auth#show'
    end
  end
end
