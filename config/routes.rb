Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/contacts' => 'contacts#index'
  post '/contacts' => 'contacts#create'
  get '/contacts/:id' => 'contacts#show'
  patch '/contacts/:id' => 'contacts#update'
  delete '/contacts/:id' => 'contacts#destroy'

  post "/users" => "users#create"
end
