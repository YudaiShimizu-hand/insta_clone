Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'users#new'

get '/login', to: 'user_sessions#new'
post '/login', to: 'user_sessions#create'
delete '/logout', to: 'user_sessions#destroy'


resources :users
resources :relationships, only: [:create, :destroy]

resources :posts, shallow: true do
  resources :comments
  resources :likes
  collection do
    get :like_posts
    get :search
  end
end

end
