Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :users
get '/login', to: 'user_sessions#new'
post '/login', to: 'user_sessions#create'
delete '/login', to: 'user_sessions#destroy'


end
